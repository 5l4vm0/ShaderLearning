Shader "Custom/VertexShader"
{
    Properties
    {
       _MainTex("Main Texture", 2D) = "white"{}
    }
    SubShader
    {
       pass
       {
        CGPROGRAM

            #include "UnityCG.cginc"
        
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;

            struct VertexInput
            {
                float4 pos: POSITION;
                float2 uv: TEXCOORD0;
            };

            struct VertexOutput
            {
                float4 pos: SV_POSITION;
                float2 uv:TEXCOORD0;
            };

            VertexOutput vert (VertexInput i)
            {
                VertexOutput o;

                //float offset = cos(i.uv.y*20)*0.2;
                //float wave = cos(i.uv.x+offset)+_Time.y;
                float wave = cos(i.uv.x*10+_Time.y);
                
                i.pos.y = wave;
                
                o.pos = UnityObjectToClipPos(i.pos);
                o.uv = i.uv;
                return o;
            }

            float4 frag(VertexOutput o):SV_TARGET
            {
                //float offset = cos(o.uv.y*20)*0.2;
                float wave = cos((o.uv.x)*10+_Time.y)*0.5+0.5;
                return wave* tex2D(_MainTex,o.uv);
            }

        ENDCG
       }
    }
    
}
