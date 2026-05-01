Shader "yky/SimpleNightVision"
{
    Properties
    {
        _NVColor ("Night Vision Color", Color) = (0, 1, 0.2, 1)
        _MainTex ("UI Atlas (0-9)", 2D) = "white" {}
        _UIPosX ("UI Position X", Range(0, 1)) = 0.7
        _UIPosY ("UI Position Y", Range(0, 1)) = 0.1
        _UIScale ("UI Scale", Range(1, 100)) = 45.0
        _Brightness ("Brightness Gain", Range(0, 5)) = 1.2
        _Gamma ("Gamma", Range(-5, 5)) = 0
        _MinLight ("Darkness Compensation", Range(0, 1)) = 0.2
        _Noise ("Noise", Range(0, 1)) = 0.02
        [Toggle(SCAN_ON)] _Scan ("Enable Scanning", Float) = 1
        _ScanSpeed ("Scan Speed", Range(0, 5)) = 0.5
        _ScanWidth ("Scan Width", Range(0, 0.1)) = 0.02
        _OutlineSharpness ("Outline Sharpness", Range(0, 50)) = 10.0
        [Toggle(MASK_ON)] _Mask ("Enable Vignette Mask", Float) = 1
        [Toggle(PERFECT_CIRCLE_ON)] _PerfectCircle ("Perfect Circle Mask", Float) = 0
        _VignetteRadius ("Vignette Radius", Range(0, 1)) = 0.5
        _VignetteSoftness ("Vignette Softness", Range(0, 1)) = 0.4
        _VROffset ("VR Eye Offset", Range(-0.1, 0.1)) = 0.01
    }
    SubShader
    {
        Tags
        {
            "Queue"="Transparent+100" "RenderType"="Transparent"
        }
        Cull Front
        ZWrite Off
        ZTest Always
        Lighting Off
        GrabPass
        {
            "_GrabTexture"
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature PERFECT_CIRCLE_ON
            #pragma shader_feature MASK_ON
            #pragma shader_feature SCAN_ON
            #include "UnityCG.cginc"

            sampler2D _GrabTexture, _MainTex;
            UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
            float _VRChatCameraMode, _VRChatMirrorMode, _VRChatFaceMirrorMode;
            float _VignetteRadius, _VignetteSoftness;
            float _VROffset;
            float _PerfectCircle;
            float _Brightness, _Gamma, _MinLight, _OutlineSharpness;
            float _Noise;
            float _ScanSpeed, _ScanWidth;
            float4 _NVColor;
            float _UIPosX, _UIPosY, _UIScale;
            float4 _CameraDepthTexture_TexelSize;

            struct v2f
            {
                float4 grabPos : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            float SampleDigit(const float2 uv, const uint digit)
            {
                if (uv.x < 0 || uv.x > 1 || uv.y < 0 || uv.y > 1) return 0;
                const float2 charUV = float2((uv.x + digit) / 12.0, uv.y);
                return tex2D(_MainTex, charUV).a;
            }

            float PrintAdvancedValue(float2 uv, const float value)
            {
                float res = 0;
                const float absVal = abs(value);
                const uint intPart = uint(absVal);
                const uint decPart = uint(frac(absVal) * 10.0);

                if (value < 0)
                    res += SampleDigit(uv - float2(-0.8, 0), 10);

                res += SampleDigit(uv - float2(0.0, 0), (intPart / 10000) % 10);
                res += SampleDigit(uv - float2(0.8, 0), (intPart / 1000) % 10);
                res += SampleDigit(uv - float2(1.6, 0), (intPart / 100) % 10);
                res += SampleDigit(uv - float2(2.4, 0), (intPart / 10) % 10);
                res += SampleDigit(uv - float2(3.2, 0), intPart % 10);
                res += SampleDigit(uv - float2(4.0, 0), 11);
                res += SampleDigit(uv - float2(4.8, 0), decPart);

                return res;
            }

            v2f vert(const appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.grabPos = ComputeGrabScreenPos(o.pos);
                return o;
            }

            float rand(const float2 uv)
            {
                return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
            }

            fixed4 frag(const v2f i) : SV_Target
            {
                if (_VRChatCameraMode != 0.0 || _VRChatMirrorMode != 0.0 || _VRChatFaceMirrorMode != 0.0)
                    discard;

                const float2 uv = i.grabPos.xy / i.grabPos.w;
                const fixed4 sceneCol = tex2Dproj(_GrabTexture, i.grabPos);

                const float gammaVal = exp(-_Gamma);
                const float3 enhancedScene = pow(saturate(sceneCol.rgb), gammaVal) * _Brightness;

                const float2 dUV = _CameraDepthTexture_TexelSize.xy;
                const float dC = Linear01Depth(SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, float4(uv, 0, 0)));
                const float dN = Linear01Depth(
                    SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, float4(uv + float2(0, dUV.y), 0, 0)));
                const float dS = Linear01Depth(
                    SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, float4(uv - float2(0, dUV.y), 0, 0)));
                const float dE = Linear01Depth(
                    SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, float4(uv + float2(dUV.x, 0), 0, 0)));
                const float dW = Linear01Depth(
                    SAMPLE_DEPTH_TEXTURE_LOD(_CameraDepthTexture, float4(uv - float2(dUV.x, 0), 0, 0)));

                const float edge = abs(dN + dS + dE + dW - 4.0 * dC);
                const float outline = saturate(edge * _OutlineSharpness * 100.0);

                const float lum = dot(sceneCol.rgb, float3(0.3, 0.59, 0.11));
                const float darkness = saturate(1.0 - lum * 3.0);

                const float3 depthBase = (1.0 - dC) * _NVColor.rgb * _MinLight * darkness;

                float3 finalEnv = lerp(depthBase, enhancedScene, saturate(lum * 2.0));
                finalEnv += outline * _NVColor.rgb * 2.0;

                #ifdef SCAN_ON
                const float sweepRaw = step(frac(dC - _Time.y * _ScanSpeed), _ScanWidth);
                const float sweepFade = smoothstep(0.0, 0.05, dC) * (1.0 - dC);
                const float sweep = sweepRaw * sweepFade * 0.5;

                finalEnv += sweep * _NVColor.rgb;
                #endif

                const float dynamicNoise = (rand(uv + _Time.y) - 0.5) * _Noise;
                finalEnv = saturate(finalEnv + dynamicNoise * _NVColor.rgb);

                #ifdef MASK_ON
                float2 maskCenter = float2(0.5, 0.5);
                #if defined(USING_STEREO_MATRICES)
                const float eyeOffset = (unity_StereoEyeIndex == 0) ? -_VROffset : _VROffset;
                maskCenter.x += eyeOffset;
                #endif
                float dist = length(uv - maskCenter);
                #ifdef PERFECT_CIRCLE_ON
                dist = length((uv - maskCenter) * float2(_ScreenParams.x / _ScreenParams.y, 1.0));
                #endif
                finalEnv *= smoothstep(_VignetteRadius, _VignetteRadius - _VignetteSoftness, dist);
                #endif

                const float2 uiPos = (uv - float2(_UIPosX, _UIPosY)) * _UIScale;
                float uiAlpha = 0;

                const float3 pos = _WorldSpaceCameraPos.xyz;

                uiAlpha += PrintAdvancedValue(uiPos, pos.x);
                uiAlpha += PrintAdvancedValue(uiPos - float2(0, 1.5), pos.y);
                uiAlpha += PrintAdvancedValue(uiPos - float2(0, 3.0), pos.z);

                return fixed4(finalEnv + (uiAlpha * _NVColor.rgb * 2.0), 1.0);
            }
            ENDCG
        }
    }
}