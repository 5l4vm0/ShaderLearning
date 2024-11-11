Shader "Custom/Gradient"
{
    Properties
    {
        _Color1 ("Color1", Color) = (1,1,1,1)
        _Color2 ("Color2", Color) = (1,1,1,1)
        _Value ("Value", Range(0,1)) = 0
        _BlendStart("Blend Start", Range(0,1)) = 0
        _BlendEnd("Blend End", Range(0,1)) =0
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Transparent"
            "Queue" = "Transparent"
        }

        pass
        {
            Cull Off
            ZWrite Off // whether to write to depth buffer (Whether it can block other objects)
            ZTest Always//Whether it can be blocked
            Blend One One // Additive

            CGPROGRAM
            
            #include "UnityCG.cginc"

            #pragma vertex vert
            #pragma fragment frag

            float4 _Color1;
            float4 _Color2;
            float _Value,_BlendStart,_BlendEnd;

            struct VertexInput
            {
                float4 position: POSITION;
                float2 uv:TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct VertexOutput
            {
                float4 position: SV_POSITION;
                float2 uv:TEXCOORD0;
                float3 normal: NORMAL;
            };

            float InverseLerp(float a, float b, float v)
            {
                return(v-b)/ (a-b);
            }

            VertexOutput vert(VertexInput i)
            {
                VertexOutput o;
                o.position = UnityObjectToClipPos(i.position);
                o.uv = i.uv;
                o.normal = i.normal;
                return o;
            }


            float4 frag(VertexOutput o):SV_TARGET
            {
                //float4 color = o.uv.x <_Value? _Color1: _Color2;
                //float interpolator = saturate(InverseLerp(_BlendStart, _BlendEnd, o.uv.x)); //saturate = clamp function, return 0 if <0, return 1 if >1
                //interpolator = frac(interpolator); //frac = interpolator- floor(interpolator)
                //float4 color = lerp(_Color1, _Color2,interpolator);
                
                
                float xOffset = cos(o.uv.x*30)*0.05;
                float4 wave = cos((o.uv.y+xOffset - _Time.y * 0.1)*25)*0.5+0.5; //_Time.y global variable, y = sec
                wave *= 1-o.uv.y;
                
                float topBottomRemover = (abs(o.normal.y) < 0.999);
                float4 color = lerp(_Color1, _Color2,o.uv.y); 
                return color* wave * topBottomRemover;
            }

            ENDCG
        }

       
    }
    FallBack "Diffuse"
}
