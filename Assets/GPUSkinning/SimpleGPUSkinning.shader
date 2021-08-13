Shader "Unlit/GPUSkinningTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }

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
                float4 boneWeights01 : TANGENT;
                float4 boneWeights23 : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4x4 _WorldInverse;
            float4x4 _Matrices[100];
            float4x4 _BindPoses[100];

            v2f vert(appdata v)
            {
                v2f o;

                // Skin with 4 weights per vertex
                float4 pos =
                    mul(mul(_Matrices[v.boneWeights01.x], _BindPoses[v.boneWeights01.x]), v.vertex) * v.boneWeights01.y
                    +
                    mul(mul(_Matrices[v.boneWeights01.z], _BindPoses[v.boneWeights01.z]), v.vertex) * v.boneWeights01.w
                    +
                    mul(mul(_Matrices[v.boneWeights23.x], _BindPoses[v.boneWeights23.x]), v.vertex) * v.boneWeights23.y
                    +
                    mul(mul(_Matrices[v.boneWeights23.z], _BindPoses[v.boneWeights23.z]), v.vertex) * v.boneWeights23.w;

                // Substract the renderer position, as we want to only have bone positions into account.
                // If we do not do this, when moving the outer parents the world position will be computed twice.
                // (one for the bones, one for the renderer).
                pos = mul(_WorldInverse, pos);

                o.vertex = UnityObjectToClipPos(pos);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}