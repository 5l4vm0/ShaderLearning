Shader "Custom/Ripple"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Texture("Texture", 2D) = "white"
        _InputCentre("Input Centre", Vector) = (0.5,0.5,0,0)
    }

    SubShader
    {
        pass
        {   
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            sampler2D _Texture;
            float4 _InputCentre;
            
            struct VertexInput
            {
                float4 pos: POSITION;
                float2 uv:TEXCOORD;
            };
            
            struct VertexOutput
            {
                float4 pos: SV:POSITION;
                float2 uv:TEXCOORD;
            };

            float Wave(float2 uv, float2 centre)
            {
                float2 offset = uv-centre;
                float distanceFromCentre = length(offset);
                float wave = cos(distanceFromCentre *25 - _Time.y*3)*0.5+0.5;
                float rim = 1-distanceFromCentre*0.8;
                return wave*rim;
            }

            VertexOutput vert(VertexInput i)
            {
                VertexOutput o;
                i.pos.y = Wave(i.uv, _InputCentre.xy)*0.5;
                o.pos = UnityObjectToClipPos(i.pos);
                o.uv = i.uv;
                return o;
            }

            float4 frag(VertexOutput o):SV_TARGET
            {
                float4 tex = tex2D(_Texture, o.uv);
                return max(0.0, Wave(o.uv,_InputCentre.xy)*_Color+tex);
            }

            ENDCG
        }
    }
}
