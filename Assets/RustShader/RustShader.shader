Shader "Custom/RustShader"
{
  Properties{
    _PatternTexture ("Pattern Texture", 2D) = "white"{}
    _Texture1("Texture 1", 2D) = "white"{}
    _Texture2("Texture 2", 2D) = "white" {}
    _Value("Texture Value", Range(0,1)) = 0
    _Metallic("Metallic", Range(0,1)) =0
    _Smoothness ("Smoothness", Range(0,1)) =0
  }

  SubShader{
    Pass{

      Tags{"LightMode" = "ForwardBase"}
      
        CGPROGRAM

        #pragma vertex Vert
        #pragma fragment Frag
        #include "UnityCG.cginc"
        #include "Lighting.cginc"

        sampler2D _PatternTexture, _Texture1, _Texture2;
        float4 _PatternTexture_ST,_Texture1_ST, _Texture2_ST;
        float _Value, _Metallic,_Smoothness;

        struct VertexInput
        {
            float4 pos:POSITION;
            float2 texture1: TEXCOORD0;
            float2 texture2: TEXCOORD1;
            float2 pattern: TEXCOORD2;
            float3 normal: NORMAL;
        };

        struct VertexOutput
        {
            float4 pos: SV_POSITION;
            float2 texture1: TEXCOORD0;
            float2 texture2: TESSFACTOR1;
            float2 pattern: TEXCOORD2;
            float3 normal:NORMAL;
            float3 worldPos:TEXCOORD3;
        };

        VertexOutput Vert (VertexInput i)
        {
            VertexOutput o;
            o.pos = UnityObjectToClipPos(i.pos);
            o.worldPos = mul(unity_ObjectToWorld, i.pos);
            o.normal = normalize(UnityObjectToWorldNormal(i.normal));
            o.texture1 = TRANSFORM_TEX(i.texture1, _Texture1);
            o.texture2 = TRANSFORM_TEX(i.texture2, _Texture2);
            o.pattern = TRANSFORM_TEX(i.pattern, _PatternTexture);
            return o;
        }

        float4 Frag(VertexOutput o):SV_TARGET
        {
          float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
          float3 reflectionDirection = normalize(reflect(-lightDirection, o.normal.xyz));
          float3 viewDirection = normalize(_WorldSpaceCameraPos - o.worldPos);

          float4 texture1Color = tex2D(_Texture1, o.texture1);
          float4 texture2Color = tex2D(_Texture2, o.texture2);
          float4 textureBlend = tex2D(_PatternTexture, o.pattern);

          float4 albedo = texture1Color * (1-textureBlend.r)+ 
            (texture1Color * (1-_Value) + texture2Color * _Value) * textureBlend.r;

          float4 light = _LightColor0 * max(dot(o.normal,lightDirection),0.0);
          float4 specularlight =  _LightColor0 * max(dot(o.normal,lightDirection),0.0)* pow(max(dot(reflectionDirection,viewDirection), 0.0),_Smoothness*128);
          float4 finalLight = light + specularlight + UNITY_LIGHTMODEL_AMBIENT;

          float4 color = albedo * finalLight;
          color.a = _Metallic;
          return color;
        }

        ENDCG
    }
  }
}
