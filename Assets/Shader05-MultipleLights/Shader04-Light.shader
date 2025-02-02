// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Shader04"
{
	Properties{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Albedo", 2D) = "White"{}
		_Smoothness("Smoothness", Range(0,1)) = 0.5
		//_SpecularTint("SpeacularTint",Color) = (0.5,0.5,0.5)
		_Metallic("Metallic", Range(0,1)) =0.1
	}

	SubShader{
		Pass{
			Tags{
			"LightMode" = "ForwardBase"
		}
		CGPROGRAM

		#pragma target 3.0

		#pragma vertex MyVertexProgram
		#pragma fragment MyFragmentProgram


		# include "UnityPBSLighting.cginc"
		# include "MyLighting.cginc"

		

		ENDCG
		}
	}
}
