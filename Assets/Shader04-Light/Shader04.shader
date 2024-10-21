// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Shader04"
{
	Properties{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "White"{}
	}

	SubShader{
		Pass{
		CGPROGRAM

		#pragma vertex MyVertexProgram
		#pragma fragment MyFragmentProgram

		# include "UnityCG.cginc"

		float4 _Tint;
		sampler2D _MainTex;
		float4 _MainTex_ST;
		

		struct VertexData {
			float4 position:POSITION;
			float2 uv: TEXCOORD0;
			float3 normal: NORMAL;
		};

		struct Interpolators {
			float4 position: POSITION;
			float2 uv:TEXCOORD0;
			float3 normal:TEXCOORD1;
		};


		Interpolators MyVertexProgram(VertexData v)
		{
			Interpolators i;
			i.position = UnityObjectToClipPos(v.position);
			i.uv = TRANSFORM_TEX(v.uv, _MainTex);
			//i.normal = mul(transpose((float3x3)unity_WorldToObject), v.normal);
			i.normal = UnityObjectToWorldNormal(v.normal);
			i.normal = normalize(i.normal);
			return i;
		}

		float4 MyFragmentProgram(Interpolators i) :SV_TARGET
		{
			i.normal = normalize(i.normal);
			return float4(i.normal*0.5+0.5,1); //normal range from -1 to 1, here trying to convert it into from 0 to 1
		}

		ENDCG
		}
	}
}
