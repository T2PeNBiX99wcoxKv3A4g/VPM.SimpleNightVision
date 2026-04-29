Shader "yky/SimpleNightVision"
{
    Properties
    {
        _NVColor ("Night Vision Color", Color) = (0, 1, 0.2, 1)
        _MainTex ("UI Atlas (0-9)", 2D) = "white" {}
        _UIPosX ("UI Position X", Range(0, 1)) = 0.7
        _UIPosY ("UI Position Y", Range(0, 1)) = 0.1
        _UIScale ("UI Scale", Range(1, 100)) = 45.0
        _Brightness ("Brightness Boost", Range(0, 5)) = 1.5
        _MinLight ("Min Visibility Threshold", Range(0, 1)) = 0.2
        _Noise ("Noise", Range(0, 1)) = 0.02
        _ScanSpeed ("Scan Speed", Range(0, 5)) = 1.0
        _ScanWidth ("Scan Width", Range(0, 0.1)) = 0.02
        _OutlineSharpness ("Outline Sharpness", Range(0, 50)) = 10.0
        _VignetteRadius ("Vignette Radius", Range(0, 1)) = 0.5
        _VignetteSoftness ("Vignette Softness", Range(0, 1)) = 0.4
        [Toggle(PERFECT_CIRCLE_ON)] _PerfectCircle ("Perfect Circle", Float) = 0
        [Toggle(MASK_ON)] _Mask ("Mask", Float) = 1
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
            #include "UnityCG.cginc"

            sampler2D _GrabTexture, _CameraDepthTexture, _MainTex;
            float _VRChatCameraMode, _VRChatMirrorMode, _VRChatFaceMirrorMode;
            float _VignetteRadius, _VignetteSoftness;
            float _VROffset;
            float _PerfectCircle;
            float _Brightness;
            float _MinLight;
            float _Noise;
            float _ScanSpeed, _ScanWidth;
            float _OutlineSharpness;
            float4 _NVColor;
            float _UIPosX, _UIPosY, _UIScale;

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

                const fixed4 sceneCol = tex2Dproj(_GrabTexture, i.grabPos);
                const float lum = dot(sceneCol.rgb, float3(0.3, 0.59, 0.11));
                const float boost = max(_MinLight - lum, 0) * _Brightness;

                const float3 nvBase = sceneCol.rgb + boost;

                const float2 uv = i.grabPos.xy / i.grabPos.w;
                const float rawDepth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv);
                const float depth = Linear01Depth(rawDepth);

                const float skyGlow = smoothstep(0.1, 1.0, depth) * 0.15;
                const float depthR = Linear01Depth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv + float2(0.001, 0)));
                const float outlineD = saturate(abs(depth - depthR) * _OutlineSharpness);
                const float3 colR = tex2Dproj(_GrabTexture, i.grabPos + float4(0.002, 0, 0, 0)).rgb;
                const float outlineC = saturate(distance(sceneCol.rgb, colR) * 5.0);
                const float sweep = step(frac(depth - _Time.y * _ScanSpeed), _ScanWidth) * (1.0 - depth * 0.5);

                const float3 effects = (skyGlow + outlineD + outlineC + sweep) * _NVColor.rgb;

                const float dynamicNoise = (rand(uv + _Time.y) - 0.5) * _Noise * (1.0 + depth * 2.0);

                float3 finalEnv = saturate(nvBase + effects + (dynamicNoise * _NVColor.rgb));

                #ifdef MASK_ON
                float2 maskCenter = float2(0.5, 0.5);
                #if defined(USING_STEREO_MATRICES)
                float eyeOffset = (unity_StereoEyeIndex == 0) ? -_VROffset : _VROffset;
                maskCenter.x += eyeOffset;
                #endif
                float dist = length(uv - maskCenter);
                #ifdef PERFECT_CIRCLE_ON
                dist = length((uv - maskCenter) * float2(_ScreenParams.x / _ScreenParams.y, 1.0));
                #endif
                const float mask = smoothstep(_VignetteRadius, _VignetteRadius - _VignetteSoftness, dist);
                finalEnv *= mask;
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