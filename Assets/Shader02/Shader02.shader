// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Shader02"
{
	Properties{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "White"{}
		_DetailTex("Detail Texture",2D) = "Gray"{}
	}

	SubShader{
		Pass{
		CGPROGRAM

		#pragma vertex MyVertexProgram
		#pragma fragment MyFragmentProgram

		# include "UnityCG.cginc"

		float4 _Tint;
		sampler2D _MainTex, _DetailTex;
		float4 _MainTex_ST, _DetailTex_ST;
	
		
		struct Interpolators{
			float4 position: POSITION;
			float2 uv:TEXCOORD0;
			float2 uvDetail: TEXCOORD1;
		};

		struct VertexData {
			float4 position:POSITION;
			float2 uv: TEXCOORD0;
		};

		

		Interpolators MyVertexProgram(VertexData v)
		{
			Interpolators i;
			i.position = UnityObjectToClipPos(v.position); 
			i.uv = TRANSFORM_TEX(v.uv, _MainTex);  //Transform UV coordinate
			i.uvDetail = TRANSFORM_TEX(v.uv, _DetailTex);
			return i;
		}

		float4 MyFragmentProgram(Interpolators i) :SV_TARGET
		{
			float4 color = tex2D(_MainTex, i.uv) * _Tint; //Sampling the texture with the UV coordinates (TEX2D)
			color *= tex2D(_DetailTex, i.uvDetail)*unity_ColorSpaceDouble; //unity_ColorSPaceDouble is for correcting Gamma/Linear space 
			return color;
		}

		ENDCG
		}
	}
}
