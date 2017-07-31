Shader "Unlit/LiquidShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Density ("Density", Range(0, 1.0)) = 0.5
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;			
			float _Density;
			half4 _Color;
			uniform sampler2D _LiquidTex;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col;
				fixed4 lcol = tex2D(_LiquidTex, i.uv);
				if (lcol.a > _Density) {
					col = _Color;
				} else {
					col = tex2D(_MainTex, i.uv);
				}
					
				return col;
			}
			ENDCG
		}
	}
}
