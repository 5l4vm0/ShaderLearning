Shader "Custom/RustShader"
{
  Properties{
    _PatternTexture ("Pattern Texture", 2D) = "white"{}
    _Texture1("Texture 1", 2D) = "white"{}
    _Texture2("Texture 2", 2D) = "white" {}
    _Value("Texture Value", Range(0,1)) = 0
    _Metallic("Metallic", Range(0,1)) =0
  }

  SubShader{
    Pass{
        CGPROGRAM

        #pragma vertex Vert
        #pragma fragment Frag
        #include "UnityCG.cginc"

        sampler2D _PatternTexture, _Texture1, _Texture2;
        float4 _PatternTexture_ST,_Texture1_ST, _Texture2_ST, _MetallicTexture_ST;
        float _Value, _Metallic;

        struct VertexInput
        {
            float4 pos:POSITION;
            float2 texture1: TEXCOORD0;
            float2 texture2: TEXCOORD1;
            float2 pattern: TEXCOORD2;
        };

        struct VertexOutput
        {
            float4 pos: SV_POSITION;
            float2 texture1: TEXCOORD0;
            float2 texture2: TESSFACTOR1;
            float2 pattern: TEXCOORD2;
        };

        VertexOutput Vert (VertexInput i)
        {
            VertexOutput o;
            o.pos = UnityObjectToClipPos(i.pos);
            o.texture1 = TRANSFORM_TEX(i.texture1, _Texture1);
            o.texture2 = TRANSFORM_TEX(i.texture2, _Texture2);
            o.pattern = TRANSFORM_TEX(i.pattern, _PatternTexture);
            return o;
        }

        float4 Frag(VertexOutput o):SV_TARGET
        {
          float4 texture1Color = tex2D(_Texture1, o.texture1);
          float4 texture2Color = tex2D(_Texture2, o.texture2);
          float4 textureBlend = tex2D(_PatternTexture, o.pattern);

          float4 color = texture1Color * (1-textureBlend.r)+ 
            (texture1Color * (1-_Value) + texture2Color * _Value) * textureBlend.r;
          color.a = _Metallic;
          return color;
        }

        ENDCG
    }
  }
}
