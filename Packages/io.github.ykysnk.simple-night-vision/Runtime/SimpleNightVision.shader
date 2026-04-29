Shader "yky/SimpleNightVision"
{
    Properties
    {
        _Brightness ("Brightness Boost", Range(0, 5)) = 1.5
        _MinLight ("Min Visibility Threshold", Range(0, 1)) = 0.2
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
            #include "UnityCG.cginc"

            float _VRChatCameraMode;
            float _VRChatMirrorMode;
            float _VRChatFaceMirrorMode;

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 grabPos : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            sampler2D _GrabTexture;
            float _Brightness;
            float _MinLight;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.grabPos = ComputeGrabScreenPos(o.pos);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                if (_VRChatCameraMode != 0.0 || _VRChatMirrorMode != 0.0 || _VRChatFaceMirrorMode != 0.0)
                    discard;

                fixed4 sceneCol = tex2Dproj(_GrabTexture, i.grabPos);

                float lum = dot(sceneCol.rgb, float3(0.3, 0.59, 0.11));
                float boost = max(_MinLight - lum, 0) * _Brightness;

                sceneCol.rgb += boost;
                return sceneCol;
            }
            ENDCG
        }
    }
}