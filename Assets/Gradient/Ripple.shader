Shader "Custom/Ripple"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _Texture("Texture", 2D) = "white"
        _Decay("Decay", float) = 5
        //_InputCentre("Input Centre", Vector) = (0.5,0.5,0,0)
        //_InputCentre2 ("Input Centre", Vector) =(0,0,0,0)
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
            float _Decay;
            float4 _InputCentre[5];
            //float4 _InputCentre2;
            
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
                
                return saturate(wave)*0.5*rim;
            }

            VertexOutput vert(VertexInput i)
            {
                VertexOutput o;
                float combinedWave;
                for(int n =0; n<5; n++)
                {
                    combinedWave += Wave(i.uv, _InputCentre[n].xy);
                }

                i.pos.y = combinedWave*0.5;
                o.pos = UnityObjectToClipPos(i.pos);
                o.uv = i.uv;
                return o;
            }

            float4 frag(VertexOutput o):SV_TARGET
            {
                float4 tex = tex2D(_Texture, o.uv);
                float combinedWave;
                for(int n =0; n<5; n++)
                {
                    combinedWave += Wave(o.uv, _InputCentre[n].xy);
                }
                
                return max(0.0, saturate(combinedWave*_Color)+tex);
            }

            ENDCG
        }
    }
}
