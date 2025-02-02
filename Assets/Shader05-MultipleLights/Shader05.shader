
Shader "Custom/Shader05"
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

		# include "MyLighting.cginc"

		ENDCG
		}

		Pass{
			Tags{
			"LightMode" = "ForwardAdd"
		}
		Blend One one
		CGPROGRAM

		#pragma target 3.0

		#pragma vertex MyVertexProgram
		#pragma fragment MyFragmentProgram

		# include "MyLighting.cginc"

		

		ENDCG
		}
	}
}
