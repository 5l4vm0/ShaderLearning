// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Shader01"
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
		
		struct Interpolators{
			float4 position: POSITION;
			//float3 localPosition: TEXCOORD0;
			float2 uv:TEXCOORD0;
		};

		struct VertexData {
			float4 position:POSITION;
			float2 uv: TEXCOORD0;
		};

		//Colour sphere
		//Interpolators MyVertexProgram(float4 position:POSITION) :POSITION
		//{
		//	Interpolators i;
		//	i.localPosition = position.xyz;
		//	i.position =  UnityObjectToClipPos(position);
		//	return i;
		//	// Same as return mul(UNITY_MATRIX_MVP, position); UNITY_MATRIX_MVP is a unityShaderVariables MVP= model view projection
		//}

		//float4 MyFragmentProgram(Interpolators i):SV_TARGET
		//{
		//	return float4(i.localPosition+0.5f, 1) * _Tint; //+0.5 to offset and make position/output color to 0-1 range
		//}

		Interpolators MyVertexProgram(VertexData v)
		{
			Interpolators i;
			i.position = UnityObjectToClipPos(v.position);
			//i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw; //_MainTex_ST.xy => scaling, _MainTex_ST.xw => Offset
			i.uv = TRANSFORM_TEX(v.uv, _MainTex);
			return i;
		}

		float4 MyFragmentProgram(Interpolators i) :SV_TARGET
		{
			return tex2D(_MainTex, i.uv)*_Tint;
		}

		ENDCG
		}
	}
}
