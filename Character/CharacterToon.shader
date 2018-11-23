// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/Character/CharacterToon"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[NoScaleOffset][Header(Texture)]_Texture("Texture", 2D) = "white" {}
		[NoScaleOffset]_ToonRamp("Toon Ramp", 2D) = "white" {}
		[HDR]_BaseColor("Base Color", Color) = (1,1,1,0)
		_BaseScrollRotate("Base Scroll/Rotate", Range( 0 , 1)) = 0
		_BaseSpeedXY("Base Speed(X/Y)", Vector) = (0,0,0,0)
		_BaseRotationPosition("Base Rotation Position", Vector) = (0,0,0,0)
		[HDR]_RimColor("Rim Color", Color) = (1,1,1,0)
		_RimPower("Rim Power", Range( 0 , 1)) = 1
		_RimOffset("Rim Offset", Range( 0 , 1)) = 1
		[Toggle][Toggle(_USERIM_ON)] _UseRim("Use Rim", Float) = 0
		[Normal][NoScaleOffset][Header(Normal) ]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 10)) = 1
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionIntensity("Emission Intensity", Range( 0 , 1)) = 0
		[NoScaleOffset]_EmisionMask("Emision Mask", 2D) = "black" {}
		[Header(Outline) ]_OutlineTint("Outline Tint", Color) = (0.5294118,0.5294118,0.5294118,0)
		_OutlineWidth("Outline Width", Range( 0 , 0.2)) = 0
		[NoScaleOffset][Header(Specular) ]_SpecularMap("Specular Map", 2D) = "white" {}
		_Specular("Specular", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Occulusion)]_OcculusionMap("Occulusion Map", 2D) = "black" {}
		_OcculusionStrength("Occulusion Strength", Range( 0 , 10)) = 1
		[IntRange]_Reference("Reference", Range( 0 , 255)) = 0
		[IntRange]_ReadMask("Read Mask", Range( 0 , 255)) = 255
		[IntRange]_WriteMask("Write Mask", Range( 0 , 255)) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)]_CompFront("Comp. Front", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_PassFront("Pass Front", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_FailFront("Fail Front", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_ZFailFront("ZFail Front", Int) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_CompBack("Comp. Back", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]_PassBack("Pass Back", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_FailBack("Fail Back", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_ZFailBack("ZFail Back", Int) = 0
		[Header(Custom Toon)]_ShadowContribution("Shadow Contribution", Range( 0 , 1)) = 0.5
		_BaseCellOffset("Base Cell Offset", Range( -1 , 1)) = 0
		_BaseCellSharpness("Base Cell Sharpness", Range( 0.01 , 1)) = 0.01
		_IndirectDiffuseContribution("Indirect Diffuse Contribution", Range( 0 , 1)) = 1
		_IndirectSpecularContribution("Indirect Specular Contribution", Range( 0 , 1)) = 1
		_HighlightCellOffset("Highlight Cell Offset", Range( -1 , -0.5)) = -0.95
		_HighlightCellSharpness("Highlight Cell Sharpness", Range( 0 , 1)) = 0.01
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 4
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 25
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc tessellate:tessFunction 
		void outlineVertexDataFunc( inout appdata_full v )
		{
			float2 temp_output_2_0_g48 = _BaseSpeedXY;
			float2 temp_output_1_0_g48 = v.texcoord.xy;
			float2 panner6_g48 = ( _Time.x * temp_output_2_0_g48 + temp_output_1_0_g48);
			float cos5_g48 = cos( ( _Time.x * (temp_output_2_0_g48).x ) );
			float sin5_g48 = sin( ( _Time.x * (temp_output_2_0_g48).x ) );
			float2 rotator5_g48 = mul( temp_output_1_0_g48 - _BaseRotationPosition , float2x2( cos5_g48 , -sin5_g48 , sin5_g48 , cos5_g48 )) + _BaseRotationPosition;
			float2 lerpResult10_g48 = lerp( panner6_g48 , rotator5_g48 , _BaseScrollRotate);
			float4 tex2DNode199 = tex2Dlod( _Texture, float4( lerpResult10_g48, 0, 0.0) );
			float OutlineWidth200 = tex2DNode199.a;
			float outlineVar = ( _OutlineWidth * OutlineWidth200 );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 temp_output_2_0_g48 = _BaseSpeedXY;
			float2 temp_output_1_0_g48 = i.uv_texcoord;
			float2 panner6_g48 = ( _Time.x * temp_output_2_0_g48 + temp_output_1_0_g48);
			float cos5_g48 = cos( ( _Time.x * (temp_output_2_0_g48).x ) );
			float sin5_g48 = sin( ( _Time.x * (temp_output_2_0_g48).x ) );
			float2 rotator5_g48 = mul( temp_output_1_0_g48 - _BaseRotationPosition , float2x2( cos5_g48 , -sin5_g48 , sin5_g48 , cos5_g48 )) + _BaseRotationPosition;
			float2 lerpResult10_g48 = lerp( panner6_g48 , rotator5_g48 , _BaseScrollRotate);
			float4 tex2DNode199 = tex2D( _Texture, lerpResult10_g48 );
			float3 Diffuse201 = (( _BaseColor * tex2DNode199 )).rgb;
			o.Emission = ( Diffuse201 * (_OutlineTint).rgb );
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		Stencil
		{
			Ref [_Reference]
			ReadMask [_ReadMask]
			WriteMask [_WriteMask]
			CompFront [_CompFront]
			PassFront [_PassFront]
			FailFront [_FailFront]
			ZFailFront [_ZFailFront]
			CompBack [_CompBack]
			PassBack [_PassBack]
			FailBack [_FailBack]
			ZFailBack [_ZFailBack]
		}
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma shader_feature _USERIM_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform int _PassBack;
		uniform int _ZFailFront;
		uniform int _PassFront;
		uniform int _CompBack;
		uniform int _CullMode;
		uniform float _ReadMask;
		uniform int _CompFront;
		uniform int _FailBack;
		uniform int _ZFailBack;
		uniform float _Reference;
		uniform int _FailFront;
		uniform float _WriteMask;
		uniform float4 _BaseColor;
		uniform sampler2D _Texture;
		uniform float2 _BaseSpeedXY;
		uniform float2 _BaseRotationPosition;
		uniform float _BaseScrollRotate;
		uniform float4 _EmissionColor;
		uniform float _EmissionIntensity;
		uniform sampler2D _EmisionMask;
		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float _BaseCellOffset;
		uniform float _BaseCellSharpness;
		uniform float _ShadowContribution;
		uniform float _IndirectDiffuseContribution;
		uniform sampler2D _ToonRamp;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float4 _RimColor;
		uniform float _HighlightCellOffset;
		uniform float _HighlightCellSharpness;
		uniform sampler2D _SpecularMap;
		uniform float _Specular;
		uniform sampler2D _OcculusionMap;
		uniform float _OcculusionStrength;
		uniform float _IndirectSpecularContribution;
		uniform float _TessValue;
		uniform float _TessMin;
		uniform float _TessMax;
		uniform float _OutlineWidth;
		uniform float4 _OutlineTint;


		inline float3 ShadeSH911_g49( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		inline float4 UNITY_SAMPLE_TEXCUBE_LOD7_g49( float3 reflVect )
		{
			return UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
		}


		inline float3 DecodeHDR8_g49( float4 val )
		{
			return DecodeHDR(val,unity_SpecCube0_HDR);
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMin, _TessMax, _TessValue );
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 Outline303 = 0;
			v.vertex.xyz += Outline303;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_Normal45 = i.uv_texcoord;
			float3 normalizeResult48 = normalize( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Normal, uv_Normal45 ), _NormalScale ) )) );
			float3 NewNormal51 = normalizeResult48;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult52 = dot( NewNormal51 , ase_worldlightDir );
			float Ndot53 = dotResult52;
			float temp_output_40_0_g49 = Ndot53;
			float temp_output_19_0_g49 = ase_lightAtten;
			float temp_output_30_0_g49 = ( 1.0 - ( ( 1.0 - temp_output_19_0_g49 ) * _WorldSpaceLightPos0.w ) );
			float lerpResult31_g49 = lerp( ( saturate( ( ( temp_output_40_0_g49 + _BaseCellOffset ) / _BaseCellSharpness ) ) * temp_output_19_0_g49 ) , temp_output_30_0_g49 , _ShadowContribution);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_cast_6 = (1.0).xxx;
			float3 temp_output_74_0_g49 = NewNormal51;
			UnityGI gi48_g49 = gi;
			float3 diffNorm48_g49 = temp_output_74_0_g49;
			gi48_g49 = UnityGI_Base( data, 1, diffNorm48_g49 );
			float3 indirectDiffuse48_g49 = gi48_g49.indirect.diffuse + diffNorm48_g49 * 0.0001;
			float3 lerpResult49_g49 = lerp( temp_cast_6 , indirectDiffuse48_g49 , _IndirectDiffuseContribution);
			float3 normal11_g49 = float3(0,1,0);
			float3 localShadeSH911_g49 = ShadeSH911_g49( normal11_g49 );
			float4 transform3_g49 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult6_g49 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform3_g49 ) );
			float3 reflVect7_g49 = normalizeResult6_g49.xyz;
			float4 localUNITY_SAMPLE_TEXCUBE_LOD7_g49 = UNITY_SAMPLE_TEXCUBE_LOD7_g49( reflVect7_g49 );
			float4 val8_g49 = localUNITY_SAMPLE_TEXCUBE_LOD7_g49;
			float3 localDecodeHDR8_g49 = DecodeHDR8_g49( val8_g49 );
			float3 Lighting291 = saturate( ( ( ( lerpResult31_g49 * ase_lightColor.rgb ) + ( ase_lightColor.a * lerpResult49_g49 * temp_output_30_0_g49 ) ) + ( localShadeSH911_g49 + ( localDecodeHDR8_g49 * 0.02 ) ) ) );
			float2 temp_cast_10 = (saturate( (Ndot53*0.5 + 0.5) )).xx;
			float4 ToonRamp292 = tex2D( _ToonRamp, temp_cast_10 );
			float2 temp_output_2_0_g48 = _BaseSpeedXY;
			float2 temp_output_1_0_g48 = i.uv_texcoord;
			float2 panner6_g48 = ( _Time.x * temp_output_2_0_g48 + temp_output_1_0_g48);
			float cos5_g48 = cos( ( _Time.x * (temp_output_2_0_g48).x ) );
			float sin5_g48 = sin( ( _Time.x * (temp_output_2_0_g48).x ) );
			float2 rotator5_g48 = mul( temp_output_1_0_g48 - _BaseRotationPosition , float2x2( cos5_g48 , -sin5_g48 , sin5_g48 , cos5_g48 )) + _BaseRotationPosition;
			float2 lerpResult10_g48 = lerp( panner6_g48 , rotator5_g48 , _BaseScrollRotate);
			float4 tex2DNode199 = tex2D( _Texture, lerpResult10_g48 );
			float3 Diffuse201 = (( _BaseColor * tex2DNode199 )).rgb;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult29 = dot( NewNormal51 , ase_worldViewDir );
			#ifdef _USERIM_ON
				float3 staticSwitch227 = ( ( saturate( Ndot53 ) * pow( ( 1.0 - saturate( ( dotResult29 + _RimOffset ) ) ) , _RimPower ) ) * (_RimColor).rgb );
			#else
				float3 staticSwitch227 = float3( 0,0,0 );
			#endif
			float3 RimLight296 = staticSwitch227;
			float2 uv_SpecularMap97 = i.uv_texcoord;
			float4 temp_output_23_0_g49 = ( tex2D( _SpecularMap, uv_SpecularMap97 ) * _Specular );
			float temp_output_64_0_g49 = (temp_output_23_0_g49).w;
			float3 temp_cast_14 = (1.0).xxx;
			float3 indirectNormal20_g49 = temp_output_74_0_g49;
			float2 uv_OcculusionMap251 = i.uv_texcoord;
			Unity_GlossyEnvironmentData g20_g49 = UnityGlossyEnvironmentSetup( temp_output_64_0_g49, data.worldViewDir, indirectNormal20_g49, float3(0,0,0));
			float3 indirectSpecular20_g49 = UnityGI_IndirectSpecular( data, ( tex2D( _OcculusionMap, uv_OcculusionMap251 ) * _OcculusionStrength ).r, indirectNormal20_g49, g20_g49 );
			float3 lerpResult67_g49 = lerp( temp_cast_14 , indirectSpecular20_g49 , _IndirectSpecularContribution);
			float3 SpecSmooth315 = ( saturate( ( ( temp_output_40_0_g49 + _HighlightCellOffset ) / ( _HighlightCellSharpness * ( 1.0 - temp_output_64_0_g49 ) ) ) ) * (temp_output_23_0_g49).xyz * pow( temp_output_64_0_g49 , 1.5 ) * lerpResult67_g49 );
			c.rgb = saturate( ( ( float4( Lighting291 , 0.0 ) * ToonRamp292 * float4( Diffuse201 , 0.0 ) ) + float4( RimLight296 , 0.0 ) + float4( SpecSmooth315 , 0.0 ) ) ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 temp_output_2_0_g48 = _BaseSpeedXY;
			float2 temp_output_1_0_g48 = i.uv_texcoord;
			float2 panner6_g48 = ( _Time.x * temp_output_2_0_g48 + temp_output_1_0_g48);
			float cos5_g48 = cos( ( _Time.x * (temp_output_2_0_g48).x ) );
			float sin5_g48 = sin( ( _Time.x * (temp_output_2_0_g48).x ) );
			float2 rotator5_g48 = mul( temp_output_1_0_g48 - _BaseRotationPosition , float2x2( cos5_g48 , -sin5_g48 , sin5_g48 , cos5_g48 )) + _BaseRotationPosition;
			float2 lerpResult10_g48 = lerp( panner6_g48 , rotator5_g48 , _BaseScrollRotate);
			float4 tex2DNode199 = tex2D( _Texture, lerpResult10_g48 );
			float3 Diffuse201 = (( _BaseColor * tex2DNode199 )).rgb;
			o.Albedo = Diffuse201;
			float2 uv_EmisionMask59 = i.uv_texcoord;
			float4 temp_output_2_0_g50 = tex2D( _EmisionMask, uv_EmisionMask59 );
			float4 lerpResult33_g50 = lerp( float4( Diffuse201 , 0.0 ) , ( _EmissionColor * _EmissionIntensity ) , temp_output_2_0_g50);
			float4 Emissive336 = ( lerpResult33_g50 * temp_output_2_0_g50 );
			o.Emission = Emissive336.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "IsuzuShader.Editor.CharacterShaderCustomInspector"
}
/*ASEBEGIN
Version=15900
1927;29;1906;1004;-544.0996;506.4004;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;43;-237.466,509.6753;Float;False;1370.182;280;Comment;5;51;48;46;45;44;Normals;0.5220588,0.6044625,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-187.4669,586.185;Float;False;Property;_NormalScale;Normal Scale;12;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;144.1393,558.6755;Float;True;Property;_Normal;Normal;11;2;[Normal];[NoScaleOffset];Create;True;0;0;False;1;Header(Normal) ;None;47597c2dc9c7c0f489660fb0caf8c96f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;46;462.9224,564.9155;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;48;704.5572,563.972;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1155.82,925.0117;Float;False;2380.421;525.8811;Comment;17;296;227;42;38;39;35;37;36;34;32;33;31;30;29;28;27;26;Rim Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;889.713,565.423;Float;False;NewNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;26;-1058.789,1136.79;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;47;-1139.175,505.9388;Float;False;835.6508;341.2334;Comment;4;53;52;50;49;N dot L;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1105.82,1025.581;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;56;-794.4186,-97.46494;Float;False;1935.037;489.5319;Comment;12;238;237;228;234;200;201;78;23;22;199;305;312;BaseColor;0,0.2965517,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;49;-1095.027,691.5747;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;29;-753.6873,1071.898;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-811.0862,1189.115;Float;False;Property;_RimOffset;Rim Offset;9;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1062.117,555.9388;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-749.9927,184.8898;Float;False;Property;_BaseScrollRotate;Base Scroll/Rotate;4;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;238;-725.4527,257.3829;Float;False;Property;_BaseRotationPosition;Base Rotation Position;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;228;-708.0945,-56.05414;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;234;-687.4666,66.76782;Float;False;Property;_BaseSpeedXY;Base Speed(X/Y);5;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DotProductOpNode;52;-764.8846,592.7377;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-530.0884,1076.115;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;312;-401.6788,83.11462;Float;False;UVMove;-1;;48;76d828458def6914aae3d4d31eea21e6;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;31;-370.0886,1076.115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-546.5259,596.0532;Float;False;Ndot;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;199;-84.08847,91.39728;Float;True;Property;_Texture;Texture;1;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Texture);None;503a4010ad34d784a9b9c8d4f2eda87f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;245;-107.4482,-428.6833;Float;False;1237.274;282.8428;Comment;6;292;240;243;242;244;241;Toon Ramp;1,0.5808823,0.5808823,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-306.0886,1204.115;Float;False;Property;_RimPower;Rim Power;8;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-194.089,1076.115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;305;225.4185,185.7562;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-238.7209,975.0118;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;-20.99937,-378.6831;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-104.959,-1406.916;Float;False;1218.836;861.8198;Comment;11;291;315;326;309;307;14;98;287;251;288;97;Custom Toon;0.9448276,1,0,1;0;0
Node;AmplifyShaderEditor.ColorNode;22;248.4445,8.113924;Float;False;Property;_BaseColor;Base Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;244;-57.44882,-271.4586;Float;False;Constant;_WrapperValue;Wrapper Value;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;7.303577,1236.219;Float;False;Property;_RimColor;Rim Color;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0.377;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;35;-12.86537,996.8718;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;251;-61.33232,-850.5721;Float;True;Property;_OcculusionMap;Occulusion Map;20;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Occulusion);None;8ce2bdecc6f0ed046a875fe22ab67876;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;37;-2.088512,1076.115;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;288;-48.47482,-651.2235;Float;False;Property;_OcculusionStrength;Occulusion Strength;21;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-64.45379,-1137.548;Float;True;Property;_SpecularMap;Specular Map;18;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Specular) ;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;98;-48.06088,-944.9161;Float;False;Property;_Specular;Specular;19;0;Create;True;0;0;False;0;0;0.119;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;546.8309,154.9855;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;242;163.5797,-377.8186;Float;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;38;291.1359,1244.297;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;282.0397,1004.889;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;309;178.418,-1286.498;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;78;722.9694,150.9022;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;243;401.5797,-375.8186;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;326;196.7715,-1358.39;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;247.4325,-1134.816;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;67;-25.72071,1559.512;Float;False;1234.357;425.3915;Comment;9;303;75;74;73;72;71;70;69;68;Alpha Outline;1,0.6029412,0.7097364,1;0;0
Node;AmplifyShaderEditor.LightAttenuation;14;170.787,-1205.467;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;287;262.3381,-851.5178;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;335;469.7337,-1216.319;Float;True;CustomToon;33;;49;b531bc1913629eb43bf9b643b2b02ae3;0;5;40;FLOAT;0;False;74;FLOAT3;0,0,0;False;19;FLOAT;0;False;23;FLOAT4;0,0,0,0;False;24;FLOAT;1;False;2;FLOAT3;72;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;293.5427,272.1658;Float;False;OutlineWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;567.9936,997.9408;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;68;34.79198,1701.554;Float;False;Property;_OutlineTint;Outline Tint;16;0;Create;True;0;0;False;1;Header(Outline) ;0.5294118,0.5294118,0.5294118,0;0.5294118,0.5294118,0.5294118,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;240;575.9723,-368.6383;Float;True;Property;_ToonRamp;Toon Ramp;2;1;[NoScaleOffset];Create;True;0;0;False;0;None;ac638dfccf4899746a13f9a511c240bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;201;928.8756,153.0133;Float;False;Diffuse;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;69;338.4719,1703.795;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;227;812.8864,969.3873;Float;False;Property;_UseRim;Use Rim;10;0;Create;True;0;0;False;1;Toggle;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;72;306.9788,1802.78;Float;False;Property;_OutlineWidth;Outline Width;17;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;287.5521,1613.754;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;58;1159.134,-1232.124;Float;False;857.0638;704.6944;Comment;6;225;60;63;59;62;336;Emissive Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;326.0378,1904.497;Float;False;200;OutlineWidth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;869.4985,-1073.174;Float;True;Lighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;300;1191.347,-291.9316;Float;False;630.7584;532.4586;Comment;9;332;299;348;356;297;317;298;293;294;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;292;917.7202,-365.2469;Float;False;ToonRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;296;1020.133,974.9568;Float;False;RimLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;598.3265,1655.795;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.3382353,0.3382353,0.3382353;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;868.2665,-1302.777;Float;True;SpecSmooth;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;59;1170.073,-1005.498;Float;True;Property;_EmisionMask;Emision Mask;15;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;649.3604,1807.849;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;63;1253.072,-815.4973;Float;False;Property;_EmissionColor;Emission Color;13;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;60;1253.072,-1199.497;Float;True;201;Diffuse;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;62;1192.072,-639.4977;Float;False;Property;_EmissionIntensity;Emission Intensity;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;294;1197.347,-174.9315;Float;False;292;ToonRamp;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;1198.347,-249.9316;Float;False;291;Lighting;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;298;1198.347,-99.93156;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;253;1300.577,515.6598;Float;False;724.3118;747.0767;Comment;2;269;254;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;225;1517.001,-962.8992;Float;True;EmissiveMask;-1;;50;8475a84330edb2b41933a47e12b3e1d8;0;4;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;317;1196.336,142.4685;Float;False;315;SpecSmooth;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;297;1197.347,56.06844;Float;False;296;RimLight;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OutlineNode;75;763.8909,1657.573;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;356;1405.615,-173.2549;Float;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;254;1330.143,604.8593;Float;False;232;165;Comment;1;252;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;345;-1401.728,-535.8896;Float;False;1248.516;345.7109;Comment;8;351;347;344;341;343;342;340;339;Matcap;0.6965518,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;303;985.3972,1662.14;Float;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;269;1590.726,606.6865;Float;False;408.8691;641.6335;Comment;11;258;257;267;268;265;266;264;260;259;263;262;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;299;1548.73,-78.42086;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;1796.31,-959.9738;Float;False;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;268;1817.961,1126.899;Float;False;Property;_ZFailBack;ZFail Back;32;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;1609.961,646.8983;Float;False;Property;_Reference;Reference;22;1;[IntRange];Create;True;0;0;True;0;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewMatrixNode;339;-1346.839,-484.2898;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1832.754,-260.2709;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;260;1609.961,886.8987;Float;False;Property;_CompFront;Comp. Front;25;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;267;1817.961,1046.899;Float;False;Property;_FailBack;Fail Back;31;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;347;-355.891,-398.9697;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;259;1609.961,806.8982;Float;False;Property;_WriteMask;Write Mask;24;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;351;-1383.575,-383.7619;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;344;-785.8837,-443.1938;Float;True;Property;_Matcap;Matcap;41;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;263;1609.961,1046.899;Float;False;Property;_FailFront;Fail Front;27;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;1832.123,-180.5898;Float;False;336;Emissive;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;302;1836.427,47.73365;Float;False;303;Outline;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;252;1374.577,654.7596;Float;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;2;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;266;1817.961,966.8989;Float;False;Property;_PassBack;Pass Back;30;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;348;1197.798,-24.98536;Float;False;347;Matcap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;262;1609.961,966.8989;Float;False;Property;_PassFront;Pass Front;26;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;341;-1190.897,-346.081;Float;False;Constant;_Float3;Float 3;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;264;1609.961,1126.899;Float;False;Property;_ZFailFront;ZFail Front;28;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;258;1609.961,726.8981;Float;False;Property;_ReadMask;Read Mask;23;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;343;-905.5889,-416.0997;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;265;1817.961,886.8987;Float;False;Property;_CompBack;Comp. Back;29;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;-1038.648,-455.6139;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;332;1685.006,-77.5292;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;-1188.296,-454.504;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2079.255,-251.446;Float;False;True;6;Float;IsuzuShader.Editor.CharacterShaderCustomInspector;0;0;CustomLighting;ASE/Character/CharacterToon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;1;True;282;0;True;283;True;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;True;0;False;Opaque;Transparent;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;True;0;True;257;255;True;258;255;True;259;0;True;260;0;True;262;0;True;263;0;True;264;0;True;265;0;True;266;0;True;267;0;True;268;True;0;4;10;25;False;0.5;True;0;5;True;271;10;True;273;2;5;True;277;10;True;276;0;True;275;1;True;278;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;42;0;True;0;0;True;252;-1;0;True;270;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;5;44;0
WireConnection;46;0;45;0
WireConnection;48;0;46;0
WireConnection;51;0;48;0
WireConnection;29;0;27;0
WireConnection;29;1;26;0
WireConnection;52;0;50;0
WireConnection;52;1;49;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;312;1;228;0
WireConnection;312;2;234;0
WireConnection;312;3;237;0
WireConnection;312;4;238;0
WireConnection;31;0;30;0
WireConnection;53;0;52;0
WireConnection;199;1;312;0
WireConnection;32;0;31;0
WireConnection;305;0;199;0
WireConnection;35;0;34;0
WireConnection;37;0;32;0
WireConnection;37;1;33;0
WireConnection;23;0;22;0
WireConnection;23;1;305;0
WireConnection;242;0;241;0
WireConnection;242;1;244;0
WireConnection;242;2;244;0
WireConnection;38;0;36;0
WireConnection;39;0;35;0
WireConnection;39;1;37;0
WireConnection;78;0;23;0
WireConnection;243;0;242;0
WireConnection;307;0;97;0
WireConnection;307;1;98;0
WireConnection;287;0;251;0
WireConnection;287;1;288;0
WireConnection;335;40;326;0
WireConnection;335;74;309;0
WireConnection;335;19;14;0
WireConnection;335;23;307;0
WireConnection;335;24;287;0
WireConnection;200;0;199;4
WireConnection;42;0;39;0
WireConnection;42;1;38;0
WireConnection;240;1;243;0
WireConnection;201;0;78;0
WireConnection;69;0;68;0
WireConnection;227;0;42;0
WireConnection;291;0;335;0
WireConnection;292;0;240;0
WireConnection;296;0;227;0
WireConnection;73;0;71;0
WireConnection;73;1;69;0
WireConnection;315;0;335;72
WireConnection;74;0;72;0
WireConnection;74;1;70;0
WireConnection;225;1;60;0
WireConnection;225;2;59;0
WireConnection;225;3;63;0
WireConnection;225;4;62;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;356;0;293;0
WireConnection;356;1;294;0
WireConnection;356;2;298;0
WireConnection;303;0;75;0
WireConnection;299;0;356;0
WireConnection;299;1;297;0
WireConnection;299;2;317;0
WireConnection;336;0;225;0
WireConnection;347;0;344;0
WireConnection;344;1;343;0
WireConnection;343;0;342;0
WireConnection;343;1;341;0
WireConnection;342;0;340;0
WireConnection;342;1;341;0
WireConnection;332;0;299;0
WireConnection;340;0;339;0
WireConnection;340;1;351;0
WireConnection;0;0;197;0
WireConnection;0;2;337;0
WireConnection;0;13;332;0
WireConnection;0;11;302;0
ASEEND*/
//CHKSM=A81D8471807913C3FA8B1148D6A7298145E036E0