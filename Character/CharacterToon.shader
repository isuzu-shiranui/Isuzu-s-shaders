// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/Character/CharacterToon"
{
	Properties
	{
		[NoScaleOffset][Header(Texture)]_Texture("Texture", 2D) = "white" {}
		[NoScaleOffset]_ToonRamp("Toon Ramp", 2D) = "white" {}
		[HDR]_BaseColor("Base Color", Color) = (1,1,1,0)
		_BaseScrollRotate("Base Scroll/Rotate", Range( 0 , 1)) = 0
		_BaseSpeedXY("Base Speed(X/Y)", Vector) = (0,0,0,0)
		_BaseRotationPosition("Base Rotation Position", Vector) = (0,0,0,0)
		_BaseCellOffset("Base Cell Offset", Range( -1 , 1)) = 0.5
		_BaseCellSharpness("Base Cell Sharpness", Range( 0.01 , 1)) = 1
		_IndirectDiffuseContribution("Indirect Diffuse Contribution", Range( 0 , 1)) = 1
		_HighlightCellOffset("Highlight Cell Offset", Range( -1 , -0.5)) = -0.95
		_HighlightCellSharpness("Highlight Cell Sharpness", Range( 0.001 , 1)) = 0.01
		_ShadowContribution("Shadow Contribution", Range( 0 , 1)) = 0.5
		[NoScaleOffset][Header(Matcap)]_Matcap("Matcap", 2D) = "black" {}
		[NoScaleOffset][Header(Parallax Mapping) ]_Mid("Mid", 2D) = "black" {}
		[HDR]_MidColor("Mid Color", Color) = (1,1,1,1)
		_MidDepthScale("Mid Depth Scale", Range( 0 , 1)) = 0
		_MidScrollRotate("Mid Scroll/Rotate", Range( 0 , 1)) = 0
		_MidSpeedXY("Mid Speed(X/Y)", Vector) = (0,0,0,0)
		_MidRotationPosition("Mid Rotation Position", Vector) = (0,0,0,0)
		[NoScaleOffset]_Back("Back", 2D) = "black" {}
		[HDR]_BackColor("Back Color", Color) = (1,1,1,1)
		_BackDepthScale("Back Depth Scale", Range( 0 , 1)) = 0
		_BackScrollRotate("Back Scroll/Rotate", Range( 0 , 1)) = 0
		_BackSpeedXY("Back Speed(X/Y)", Vector) = (0,0,0,0)
		_BackRotationPosition("Back Rotation Position", Vector) = (0,0,0,0)
		[NoScaleOffset]_Mask("Mask", 2D) = "black" {}
		[HDR][Header(Rim Light)]_RimColor("Rim Color", Color) = (1,1,1,0)
		_RimPower("Rim Power", Range( 0 , 1)) = 1
		_RimOffset("Rim Offset", Range( 0 , 1)) = 1
		[Toggle][Toggle(_USERIM_ON)] _UseRim("Use Rim", Float) = 0
		[Normal][NoScaleOffset][Header(Normal) ]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 10)) = 1
		[HDR][Header(Emission)]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionIntensity("Emission Intensity", Range( 0 , 1)) = 1
		[NoScaleOffset]_EmisionMask("Emision Mask", 2D) = "gray" {}
		[NoScaleOffset][Header(Specular) ]_SpecularMap("Specular Map", 2D) = "black" {}
		_SpecularTint("Specular Tint", Color) = (1,1,1,0)
		[Header(Anisotropic)]_AnisotropyX("Anisotropy X", Range( 0 , 1)) = 1
		_AnisotropyY("Anisotropy Y", Range( 0 , 1)) = 1
		_AnisotropyX2("Anisotropy X2", Range( 0 , 1)) = 1
		_AnisotropyY2("Anisotropy Y2", Range( 0 , 1)) = 1
		_Layer2BlendWeight("Layer2 Blend Weight", Range( 0 , 1)) = 0.3
		[Toggle(_USEANISOTROPIC_ON)] _UseAnisotropic("Use Anisotropic", Float) = 1
		[NoScaleOffset][Header(Occulusion)]_OcculusionMap("Occulusion Map", 2D) = "white" {}
		_OcculusionStrength("Occulusion Strength", Range( 0 , 10)) = 1
		[Header(Subsurface Scattering)][KeywordEnum(Simple,Advanced)] _SSSType("SSS Type", Float) = 0
		_SSSMap("SSS Map", 2D) = "white" {}
		_SSSMultiplier("SSS Multiplier", Float) = 1
		_SSSColor("SSS Color", Color) = (0,0,0,0)
		_SSSColorPower("SSS Color Power", Float) = 4
		_SSSScale("SSS Scale", Float) = 1
		_SSSPower("SSS Power", Float) = 1
		_ShadowStrength("Shadow Strength", Range( 0 , 1)) = 1
		_PointLightPunchthrough("Point Light Punchthrough", Range( 0 , 1)) = 1
		_SubsurfaceDistortion("Subsurface Distortion", Range( 0 , 1)) = 0.822
		[Toggle(_USESSS_ON)] _UseSSS("Use SSS", Float) = 0
		[Header(Transparency)]_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 1
		[Header(Outline) ]_OutlineTint("Outline Tint", Color) = (0.5294118,0.5294118,0.5294118,0)
		_OutlineWidth("Outline Width", Range( 0 , 0.2)) = 0
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 1
		_TessMin( "Tess Min Distance", Float ) = 1
		_TessMax( "Tess Max Distance", Float ) = 5
		_TessPhongStrength( "Phong Tess Strength", Range( 0, 1 ) ) = 0.0001
		[Header(Render Texture)]_RenderTexture("Render Texture", 2D) = "black" {}
		_ReflectionBlend("Reflection Blend", Range( 0 , 1)) = 1
		[IntRange][Header(Stencil Buffer)]_Reference("Reference", Range( 0 , 255)) = 0
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
		[Enum(UnityEngine.Rendering.BlendMode)][Header(Blend)]_BlendRGBSrc("Blend RGB Src", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)]_BlendRGBDst("Blend RGB Dst", Float) = 10
		[Enum(UnityEngine.Rendering.BlendOp)]_BlendOpRGB("Blend Op RGB", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_BlendAlphaSrc("Blend Alpha Src", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)]_BlendAlphaDst("Blend Alpha Dst", Float) = 10
		[Enum(UnityEngine.Rendering.BlendOp)]_BlendOpAlpha("Blend Op Alpha", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(Rendering)]_CullMode("Cull Mode", Int) = 0
		[Toggle(_USELIGHTCOLOR_ON)] _UseLightColor("Use Light Color", Float) = 1
		[Toggle(_STATICHIGHLIGHTS_ON)] _StaticHighLights("Static HighLights", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 
		void outlineVertexDataFunc( inout appdata_full v )
		{
			float outlineVar = _OutlineWidth;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 temp_output_2_0_g71 = _BaseSpeedXY;
			float2 temp_output_1_0_g71 = i.uv_texcoord;
			float2 panner6_g71 = ( _Time.x * temp_output_2_0_g71 + temp_output_1_0_g71);
			float cos5_g71 = cos( ( _Time.x * (temp_output_2_0_g71).x ) );
			float sin5_g71 = sin( ( _Time.x * (temp_output_2_0_g71).x ) );
			float2 rotator5_g71 = mul( temp_output_1_0_g71 - _BaseRotationPosition , float2x2( cos5_g71 , -sin5_g71 , sin5_g71 , cos5_g71 )) + _BaseRotationPosition;
			float2 lerpResult10_g71 = lerp( panner6_g71 , rotator5_g71 , _BaseScrollRotate);
			half4 tex2DNode199 = tex2D( _Texture, lerpResult10_g71 );
			float4 temp_output_549_0 = ( tex2DNode199 * _BaseColor );
			float4 Diffuse201 = temp_output_549_0;
			float OpacityMask585 = tex2DNode199.a;
			o.Emission = ( Diffuse201 * half4( (_OutlineTint).rgb , 0.0 ) ).rgb;
			clip( OpacityMask585 - _MaskClipValue );
		}
		ENDCG
		

		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 100
		Cull [_CullMode]
		ZWrite On
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
		Blend [_BlendRGBSrc] [_BlendRGBDst] , SrcAlpha OneMinusSrcAlpha
		BlendOp [_BlendOpRGB] , Add
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Tessellation.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma shader_feature _USEANISOTROPIC_ON
		#pragma shader_feature _STATICHIGHLIGHTS_ON
		#pragma shader_feature _USERIM_ON
		#pragma shader_feature _USESSS_ON
		#pragma shader_feature _SSSTYPE_SIMPLE _SSSTYPE_ADVANCED
		#pragma shader_feature _USELIGHTCOLOR_ON
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
			half2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float3 worldPos;
			float3 worldNormal;
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

		uniform half _BlendRGBDst;
		uniform int _CompFront;
		uniform int _ZFailBack;
		uniform int _CompBack;
		uniform half _MaskClipValue;
		uniform half _BlendAlphaSrc;
		uniform int _CullMode;
		uniform half _Reference;
		uniform half _BlendRGBSrc;
		uniform half _BlendOpAlpha;
		uniform half _BlendAlphaDst;
		uniform int _PassBack;
		uniform int _FailFront;
		uniform int _ZFailFront;
		uniform int _FailBack;
		uniform int _PassFront;
		uniform half _ReadMask;
		uniform half _BlendOpRGB;
		uniform half _WriteMask;
		uniform sampler2D _Texture;
		uniform half2 _BaseSpeedXY;
		uniform half2 _BaseRotationPosition;
		uniform half _BaseScrollRotate;
		uniform half4 _BaseColor;
		uniform sampler2D _EmisionMask;
		uniform half4 _EmissionColor;
		uniform half _EmissionIntensity;
		uniform sampler2D _RenderTexture;
		uniform float4 _RenderTexture_ST;
		uniform sampler2D _Back;
		uniform half2 _BackSpeedXY;
		uniform half _BackDepthScale;
		uniform half2 _BackRotationPosition;
		uniform half _BackScrollRotate;
		uniform half4 _BackColor;
		uniform sampler2D _Mid;
		uniform half2 _MidSpeedXY;
		uniform half _MidDepthScale;
		uniform half2 _MidRotationPosition;
		uniform half _MidScrollRotate;
		uniform half4 _MidColor;
		uniform half _ReflectionBlend;
		uniform sampler2D _Mask;
		uniform half _Opacity;
		uniform sampler2D _OcculusionMap;
		uniform half _OcculusionStrength;
		uniform sampler2D _SpecularMap;
		uniform half4 _SpecularTint;
		uniform half _NormalScale;
		uniform sampler2D _Normal;
		uniform half _AnisotropyX;
		uniform half _AnisotropyY;
		uniform half _AnisotropyX2;
		uniform half _AnisotropyY2;
		uniform half _Layer2BlendWeight;
		uniform half _HighlightCellOffset;
		uniform half _HighlightCellSharpness;
		uniform half _RimOffset;
		uniform half _RimPower;
		uniform half4 _RimColor;
		uniform sampler2D _SSSMap;
		uniform float4 _SSSMap_ST;
		uniform half _SSSPower;
		uniform half _SSSScale;
		uniform half4 _SSSColor;
		uniform half _SubsurfaceDistortion;
		uniform half _SSSMultiplier;
		uniform half _ShadowStrength;
		uniform half _PointLightPunchthrough;
		uniform half _SSSColorPower;
		uniform half _IndirectDiffuseContribution;
		uniform half _BaseCellOffset;
		uniform half _BaseCellSharpness;
		uniform half _ShadowContribution;
		uniform sampler2D _ToonRamp;
		uniform sampler2D _Matcap;
		uniform half _TessValue;
		uniform half _TessMin;
		uniform half _TessMax;
		uniform half _TessPhongStrength;
		uniform half _OutlineWidth;
		uniform half4 _OutlineTint;


		inline float3 ShadeSH9418( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		inline float4 UNITY_SAMPLE_TEXCUBE_LOD416( float3 reflVect )
		{
			return UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
		}


		inline float3 DecodeHDR413( float4 val )
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
			float2 temp_output_2_0_g71 = _BaseSpeedXY;
			float2 temp_output_1_0_g71 = i.uv_texcoord;
			float2 panner6_g71 = ( _Time.x * temp_output_2_0_g71 + temp_output_1_0_g71);
			float cos5_g71 = cos( ( _Time.x * (temp_output_2_0_g71).x ) );
			float sin5_g71 = sin( ( _Time.x * (temp_output_2_0_g71).x ) );
			float2 rotator5_g71 = mul( temp_output_1_0_g71 - _BaseRotationPosition , float2x2( cos5_g71 , -sin5_g71 , sin5_g71 , cos5_g71 )) + _BaseRotationPosition;
			float2 lerpResult10_g71 = lerp( panner6_g71 , rotator5_g71 , _BaseScrollRotate);
			half4 tex2DNode199 = tex2D( _Texture, lerpResult10_g71 );
			float OpacityMask585 = tex2DNode199.a;
			float2 uv_OcculusionMap251 = i.uv_texcoord;
			half4 temp_cast_1 = (_OcculusionStrength).xxxx;
			float temp_output_473_0 = (pow( tex2D( _OcculusionMap, uv_OcculusionMap251 ) , temp_cast_1 )).r;
			float2 uv_SpecularMap97 = i.uv_texcoord;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult392 = normalize( ase_worldlightDir );
			float3 normalizeResult388 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float3 normalizeResult395 = normalize( ( normalizeResult392 + normalizeResult388 ) );
			float2 uv_Normal45 = i.uv_texcoord;
			float3 normalizeResult48 = normalize( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Normal, uv_Normal45 ), _NormalScale ) )) );
			float3 NormalDirection51 = normalizeResult48;
			half3 ase_worldBitangent = WorldNormalVector( i, half3( 0, 1, 0 ) );
			float3 normalizeResult399 = normalize( cross( NormalDirection51 , ase_worldBitangent ) );
			float dotResult377 = dot( normalizeResult395 , normalizeResult399 );
			float temp_output_375_0 = ( dotResult377 / _AnisotropyX );
			half3 ase_worldTangent = WorldNormalVector( i, half3( 1, 0, 0 ) );
			float3 normalizeResult382 = normalize( cross( NormalDirection51 , ase_worldTangent ) );
			float dotResult376 = dot( normalizeResult395 , normalizeResult382 );
			float temp_output_374_0 = ( dotResult376 / _AnisotropyY );
			float dotResult402 = dot( NormalDirection51 , normalizeResult395 );
			float dotResult52 = dot( NormalDirection51 , ase_worldlightDir );
			float NdotL53 = dotResult52;
			float temp_output_630_0 = ( dotResult377 / _AnisotropyX2 );
			float temp_output_629_0 = ( dotResult376 / _AnisotropyY2 );
			#ifdef _USEANISOTROPIC_ON
				float staticSwitch652 = ( ( exp( ( ( ( ( temp_output_375_0 * temp_output_375_0 ) + ( temp_output_374_0 * temp_output_374_0 ) ) / ( dotResult402 + 1.0 ) ) * -2.0 ) ) * max( NdotL53 , 0.0 ) ) + ( exp( ( ( ( ( temp_output_630_0 * temp_output_630_0 ) + ( temp_output_629_0 * temp_output_629_0 ) ) / ( dotResult402 + 1.0 ) ) * -2.0 ) ) * max( NdotL53 , 0.0 ) * _Layer2BlendWeight ) );
			#else
				float staticSwitch652 = 0.0;
			#endif
			float Anisotropic360 = staticSwitch652;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 LightColorFalloff453 = ( ase_lightColor.rgb * ase_lightAtten );
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult4_g70 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult456 = dot( normalizeResult4_g70 , NormalDirection51 );
			#ifdef _STATICHIGHLIGHTS_ON
				float staticSwitch464 = NdotL53;
			#else
				float staticSwitch464 = dotResult456;
			#endif
			float dotResult29 = dot( NormalDirection51 , ase_worldViewDir );
			#ifdef _USERIM_ON
				float3 staticSwitch227 = ( ( saturate( NdotL53 ) * pow( ( 1.0 - saturate( ( dotResult29 + _RimOffset ) ) ) , _RimPower ) ) * (_RimColor).rgb );
			#else
				float3 staticSwitch227 = float3( 0,0,0 );
			#endif
			float3 RimLight296 = staticSwitch227;
			float2 uv_SSSMap = i.uv_texcoord * _SSSMap_ST.xy + _SSSMap_ST.zw;
			half4 tex2DNode610 = tex2D( _SSSMap, uv_SSSMap );
			float dotResult606 = dot( pow( _SSSPower , 1.0 ) , _SSSScale );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			half3 ase_worldNormal = WorldNormalVector( i, half3( 0, 0, 1 ) );
			float dotResult665 = dot( ase_worldViewDir , -( ase_worldlightDir + ( ase_worldNormal * _SubsurfaceDistortion ) ) );
			float dotResult658 = dot( pow( ( ( dotResult665 * ( 1.0 - _WorldSpaceLightPos0.w ) ) + ( _WorldSpaceLightPos0.w * ase_lightAtten ) ) , _SSSPower ) , _SSSScale );
			float temp_output_673_0 = saturate( ( tex2DNode610.r * dotResult658 * _SSSMultiplier ) );
			float temp_output_690_0 = ( ( temp_output_673_0 * saturate( ( ase_lightAtten + ( 1.0 - _ShadowStrength ) ) ) * ( 1.0 - _WorldSpaceLightPos0.w ) ) + ( ase_lightAtten * temp_output_673_0 * _WorldSpaceLightPos0.w * _PointLightPunchthrough ) );
			float4 lerpResult695 = lerp( _SSSColor , ase_lightColor , saturate( pow( temp_output_690_0 , _SSSColorPower ) ));
			#if defined(_SSSTYPE_SIMPLE)
				float3 staticSwitch700 = ( ( tex2DNode610.r * saturate( dotResult606 ) * distance( ase_vertex3Pos , float3( 0,0,0 ) ) ) * (_SSSColor).rgb );
			#elif defined(_SSSTYPE_ADVANCED)
				float3 staticSwitch700 = (( lerpResult695 * ase_lightColor.a * temp_output_690_0 )).rgb;
			#else
				float3 staticSwitch700 = ( ( tex2DNode610.r * saturate( dotResult606 ) * distance( ase_vertex3Pos , float3( 0,0,0 ) ) ) * (_SSSColor).rgb );
			#endif
			#ifdef _USESSS_ON
				float3 staticSwitch653 = staticSwitch700;
			#else
				float3 staticSwitch653 = float3( 0,0,0 );
			#endif
			float3 SSS619 = staticSwitch653;
			half3 temp_cast_5 = (1.0).xxx;
			UnityGI gi441 = gi;
			float3 diffNorm441 = NormalDirection51;
			gi441 = UnityGI_Base( data, 1, diffNorm441 );
			float3 indirectDiffuse441 = gi441.indirect.diffuse + diffNorm441 * 0.0001;
			float3 lerpResult443 = lerp( temp_cast_5 , indirectDiffuse441 , _IndirectDiffuseContribution);
			float temp_output_434_0 = ( 1.0 - ( ( 1.0 - ase_lightAtten ) * _WorldSpaceLightPos0.w ) );
			float3 normal418 = half3(0,1,0);
			float3 localShadeSH9418 = ShadeSH9418( normal418 );
			float4 transform414 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult410 = normalize( ( half4( _WorldSpaceCameraPos , 0.0 ) - transform414 ) );
			float3 reflVect416 = normalizeResult410.xyz;
			float4 localUNITY_SAMPLE_TEXCUBE_LOD416 = UNITY_SAMPLE_TEXCUBE_LOD416( reflVect416 );
			float4 val413 = localUNITY_SAMPLE_TEXCUBE_LOD416;
			float3 localDecodeHDR413 = DecodeHDR413( val413 );
			half3 temp_cast_8 = (1.0).xxx;
			#ifdef _USELIGHTCOLOR_ON
				float3 staticSwitch704 = ase_lightColor.rgb;
			#else
				float3 staticSwitch704 = temp_cast_8;
			#endif
			float lerpResult433 = lerp( temp_output_434_0 , ( saturate( ( ( NdotL53 + _BaseCellOffset ) / _BaseCellSharpness ) ) * ase_lightAtten ) , _ShadowContribution);
			float4 temp_output_549_0 = ( tex2DNode199 * _BaseColor );
			float4 Diffuse201 = temp_output_549_0;
			half2 temp_cast_9 = (saturate( (NdotL53*0.5 + 0.5) )).xx;
			float4 ToonRamp487 = tex2D( _ToonRamp, temp_cast_9 );
			float4 Matcap347 = tex2D( _Matcap, ( ( mul( UNITY_MATRIX_V, half4( ase_worldNormal , 0.0 ) ).xyz * 0.5 ) + 0.5 ).xy );
			float4 Lighting291 = saturate( ( temp_output_473_0 * ( half4( ( (( tex2D( _SpecularMap, uv_SpecularMap97 ) * _SpecularTint * Anisotropic360 )).rgb * LightColorFalloff453 * saturate( ( ( staticSwitch464 + _HighlightCellOffset ) / ( ( 1.0 - temp_output_473_0 ) * _HighlightCellSharpness ) ) ) ) , 0.0 ) + half4( RimLight296 , 0.0 ) + half4( SSS619 , 0.0 ) + half4( ( ( ( lerpResult443 * ase_lightColor.a * temp_output_434_0 * ( localShadeSH9418 + ( localDecodeHDR413 * 0.02 ) ) ) + ( staticSwitch704 * lerpResult433 ) ) * (Diffuse201).rgb * (ToonRamp487).rgb ) , 0.0 ) + Matcap347 ) ) );
			c.rgb = saturate( Lighting291 ).rgb;
			c.a = _Opacity;
			clip( OpacityMask585 - _MaskClipValue );
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
			float2 temp_output_2_0_g71 = _BaseSpeedXY;
			float2 temp_output_1_0_g71 = i.uv_texcoord;
			float2 panner6_g71 = ( _Time.x * temp_output_2_0_g71 + temp_output_1_0_g71);
			float cos5_g71 = cos( ( _Time.x * (temp_output_2_0_g71).x ) );
			float sin5_g71 = sin( ( _Time.x * (temp_output_2_0_g71).x ) );
			float2 rotator5_g71 = mul( temp_output_1_0_g71 - _BaseRotationPosition , float2x2( cos5_g71 , -sin5_g71 , sin5_g71 , cos5_g71 )) + _BaseRotationPosition;
			float2 lerpResult10_g71 = lerp( panner6_g71 , rotator5_g71 , _BaseScrollRotate);
			half4 tex2DNode199 = tex2D( _Texture, lerpResult10_g71 );
			float4 temp_output_549_0 = ( tex2DNode199 * _BaseColor );
			float4 Diffuse201 = temp_output_549_0;
			float2 uv_EmisionMask59 = i.uv_texcoord;
			float4 Emissive336 = ( Diffuse201 * tex2D( _EmisionMask, uv_EmisionMask59 ) * ( _EmissionColor * _EmissionIntensity ) );
			float2 uv_RenderTexture = i.uv_texcoord * _RenderTexture_ST.xy + _RenderTexture_ST.zw;
			float2 temp_output_2_0_g80 = _BackSpeedXY;
			float2 Offset516 = ( ( 0.0 - 1 ) * i.viewDir.xy * _BackDepthScale ) + i.uv_texcoord;
			float2 temp_output_1_0_g80 = Offset516;
			float2 panner6_g80 = ( _Time.x * temp_output_2_0_g80 + temp_output_1_0_g80);
			float cos5_g80 = cos( ( _Time.x * (temp_output_2_0_g80).x ) );
			float sin5_g80 = sin( ( _Time.x * (temp_output_2_0_g80).x ) );
			float2 rotator5_g80 = mul( temp_output_1_0_g80 - _BackRotationPosition , float2x2( cos5_g80 , -sin5_g80 , sin5_g80 , cos5_g80 )) + _BackRotationPosition;
			float2 lerpResult10_g80 = lerp( panner6_g80 , rotator5_g80 , _BackScrollRotate);
			float4 temp_output_537_0 = ( tex2D( _Back, lerpResult10_g80 ) * _BackColor );
			float2 temp_output_2_0_g81 = _MidSpeedXY;
			float2 Offset524 = ( ( 0.0 - 1 ) * i.viewDir.xy * _MidDepthScale ) + i.uv_texcoord;
			float2 temp_output_1_0_g81 = Offset524;
			float2 panner6_g81 = ( _Time.x * temp_output_2_0_g81 + temp_output_1_0_g81);
			float cos5_g81 = cos( ( _Time.x * (temp_output_2_0_g81).x ) );
			float sin5_g81 = sin( ( _Time.x * (temp_output_2_0_g81).x ) );
			float2 rotator5_g81 = mul( temp_output_1_0_g81 - _MidRotationPosition , float2x2( cos5_g81 , -sin5_g81 , sin5_g81 , cos5_g81 )) + _MidRotationPosition;
			float2 lerpResult10_g81 = lerp( panner6_g81 , rotator5_g81 , _MidScrollRotate);
			half4 tex2DNode536 = tex2D( _Mid, lerpResult10_g81 );
			float4 lerpResult547 = lerp( temp_output_537_0 , ( tex2DNode536 * _MidColor ) , tex2DNode536.a);
			float4 lerpResult550 = lerp( tex2D( _RenderTexture, uv_RenderTexture ) , lerpResult547 , _ReflectionBlend);
			float4 lerpResult554 = lerp( lerpResult550 , temp_output_549_0 , tex2D( _Mask, i.uv_texcoord ).r);
			float4 Parallax555 = lerpResult554;
			o.Emission = ( Emissive336 + Parallax555 ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 

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
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "CharacterShaderCustomInspector"
}
/*ASEBEGIN
Version=16200
7;29;1906;1004;-880.5486;-190.707;1.145332;True;True
Node;AmplifyShaderEditor.CommentaryNode;620;-1072.599,2263.031;Float;False;4321.326;1720.766;Comment;73;619;701;622;700;694;699;698;697;696;695;693;691;692;690;684;689;688;687;686;674;683;682;681;680;679;667;678;677;676;675;673;672;671;610;609;608;670;669;668;660;601;666;665;664;663;662;661;659;658;657;656;598;653;618;611;612;617;607;606;615;614;605;604;602;603;600;594;599;597;596;595;702;703;Subsurface Scattering;0.1586208,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;601;-924.498,3425.219;Float;False;Property;_SubsurfaceDistortion;Subsurface Distortion;54;0;Create;True;0;0;False;0;0.822;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;659;-846.1199,3268.504;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;660;-852.4988,3105.785;Float;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;661;-508.8017,3259.548;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;662;-352.035,3201.985;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;667;-495.4762,3458.502;Float;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;663;-303.348,2975.593;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;664;-228.3207,3203.098;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;43;-237.466,509.6753;Float;False;1370.182;280;Comment;5;51;48;46;45;44;Normals;0.5220588,0.6044625,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;665;-66.59881,3182.43;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;668;-229.476,3460.402;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;669;-337.7753,3650.404;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;405;-5165.59,507.6752;Float;False;3997.304;1674.176;Comment;50;649;361;372;371;369;390;370;651;638;639;641;643;642;637;640;631;635;636;652;360;368;367;365;634;366;362;363;633;632;364;647;375;629;374;646;630;644;378;377;379;645;402;376;403;404;396;384;401;393;389;Anisotropic;0.3054767,0.2132353,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-187.4669,586.185;Float;False;Property;_NormalScale;Normal Scale;31;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;670;104.9246,3549.704;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;144.1393,558.6755;Float;True;Property;_Normal;Normal;30;2;[Normal];[NoScaleOffset];Create;True;0;0;False;1;Header(Normal) ;None;f89d86af5d6d4fa45bf84d387c924a3d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;389;-5115.59,1522.039;Float;False;645.5051;342.6;View Direction Vector;4;386;385;388;387;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;666;105.0472,3310.026;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;656;376.4214,3337.347;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;608;343.8521,3562.699;Float;False;Property;_SSSPower;SSS Power;51;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;386;-5021.194,1701.639;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;393;-5014.68,1238.617;Float;False;519.6584;229;Light Direction Vector;2;392;391;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;385;-5092.591,1562.039;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;46;462.9224,564.9155;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;657;631.1382,3336.011;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;609;610.8525,3565.699;Float;False;Property;_SSSScale;SSS Scale;50;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;387;-4801.388,1596.74;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;391;-4964.68,1288.617;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;48;704.5572,563.972;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;680;64.82246,3689.065;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;671;815.09,3562.493;Float;False;Property;_SSSMultiplier;SSS Multiplier;47;0;Create;True;0;0;False;0;1;1.29;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;674;1020.141,3562.281;Float;False;Property;_ShadowStrength;Shadow Strength;52;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;610;664.8016,3086.956;Float;True;Property;_SSSMap;SSS Map;46;0;Create;True;0;0;False;0;None;12cd5bbf666ae084f83af472002d2935;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;658;808.9023,3336.41;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;889.713,565.423;Float;False;NormalDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;392;-4680.022,1298.385;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;384;-4363.135,914.8765;Float;False;671.0317;332.7919;Binormal Direction Vector;4;380;382;381;383;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;401;-4343.69,557.6754;Float;False;641.8149;319.6046;Tangent Direction Vector;4;397;398;399;400;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;388;-4655.086,1596.84;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;396;-4069.95,1323.715;Float;False;370.698;183;Halfway Vector;2;394;395;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightAttenuation;675;1096.71,3451.267;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;679;1030.666,3702.443;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;681;1346.323,3531.226;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;672;1029.91,3316.059;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexBinormalNode;397;-4271.47,698.2794;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexTangentNode;380;-4153.991,1117.669;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;394;-4019.95,1373.715;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;383;-4313.133,964.8766;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;400;-4293.689,607.6753;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;682;1348.679,3625.478;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;676;1493.296,3439.814;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;673;1181.77,3315.475;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;395;-3884.252,1378.293;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;381;-4034.842,997.9987;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;398;-4055.474,643.8803;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;683;1742.675,3556.462;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;687;1326.248,3717.784;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;689;1477.019,3838.996;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;677;1608.939,3434.65;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;684;1314.163,3888.991;Float;False;Property;_PointLightPunchthrough;Point Light Punchthrough;53;0;Create;True;0;0;False;0;1;0.514;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;382;-3877.101,1036.568;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;404;-3657.621,1539.415;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;399;-3886.874,669.2805;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;688;1301.12,3720.739;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;403;-3624.721,1489.115;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;376;-3321.043,1159.117;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;645;-3442.925,1848.515;Float;False;Property;_AnisotropyY2;Anisotropy Y2;40;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;678;1813.246,3359.218;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;686;1794.562,3784.038;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;644;-3438.626,1689.814;Float;False;Property;_AnisotropyX2;Anisotropy X2;39;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;377;-3319.343,942.5156;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;379;-3454.041,1327.217;Float;False;Property;_AnisotropyY;Anisotropy Y;38;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;402;-3385.518,1529.415;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;378;-3417.741,1070.916;Float;False;Property;_AnisotropyX;Anisotropy X;37;0;Create;True;0;0;False;1;Header(Anisotropic);1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;47;-1139.175,505.9388;Float;False;835.6508;341.2334;Comment;4;53;52;50;49;N dot L;0.1172419,0,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;691;1945.337,3832.901;Float;False;Property;_SSSColorPower;SSS Color Power;49;0;Create;True;0;0;False;0;4;0.46;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;690;2019.24,3631.79;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;630;-3086.358,1514.793;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;646;-3163.976,1685.165;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;375;-3092.242,965.3157;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;629;-3085.358,1776.794;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;374;-3091.242,1227.317;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;49;-1095.027,691.5747;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;632;-2854.547,1746.943;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;364;-2860.431,1197.466;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;633;-2855.946,1617.122;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1062.117,555.9388;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;692;2217.699,3734.613;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;-2861.83,1067.645;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;631;-2826.095,1890.062;Float;False;Constant;_Float1;Float 1;-1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;363;-2825.706,1389.203;Float;False;Constant;_Float4;Float 4;-1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;481;-2401.186,-2292.43;Float;False;3541.816;2618.809;Comment;14;291;484;477;479;483;482;452;476;445;446;419;621;625;655;Custom Toon;0.7793103,1,0,1;0;0
Node;AmplifyShaderEditor.WireNode;647;-3087.176,1894.764;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;635;-2656.906,1772.534;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1155.82,925.0117;Float;False;2380.421;525.8811;Comment;17;296;227;42;38;39;35;37;36;34;32;33;31;30;29;28;27;26;Rim Color;0,0.9172413,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;693;2372.232,3709.083;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;365;-2672.431,1098.466;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;634;-2666.547,1647.943;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;366;-2670.632,1262.265;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;419;-2313.258,-190.2759;Float;False;1609.518;484.417;Comment;11;408;409;410;411;412;413;414;415;416;417;418;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;52;-764.8846,592.7377;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;636;-2507.078,1655.888;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;368;-2510.731,1294.045;Float;False;Constant;_Float5;Float 5;-1;0;Create;True;0;0;False;0;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;408;-2263.258,-94.97424;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;699;2517.402,3679.802;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;617;685.0099,2766.201;Float;False;Property;_SSSColor;SSS Color;48;0;Create;True;0;0;False;0;0,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;367;-2514.531,1158.166;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;637;-2509.552,1769.811;Float;False;Constant;_Float2;Float 2;-1;0;Create;True;0;0;False;0;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;414;-2199.723,92.1413;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;497;-6725.001,-1753.182;Float;False;4219.118;2167.634;Comment;5;543;540;538;500;498;Base;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-546.5259,596.0532;Float;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;26;-1058.789,1136.79;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1105.82,1025.581;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;390;-2520.193,1393.378;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;29;-753.6873,1071.898;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;696;1509.889,2986.391;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;698;2273.577,3267.817;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-811.0862,1189.115;Float;False;Property;_RimOffset;Rim Offset;28;0;Create;True;0;0;False;0;1;0.881;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;697;2086.41,3190.851;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;369;-2498.607,1495.94;Float;False;Constant;_Float6;Float 6;-1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;417;-1922.639,8.908459;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;639;-2563.077,1857.197;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;640;-2355.115,1639.16;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;370;-2349.284,1245.125;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;595;-1022.599,2811.966;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;500;-6675.002,-1138.602;Float;False;4131.704;1523.125;Comment;41;555;554;551;550;549;548;547;546;542;541;537;536;534;529;528;526;525;524;523;522;521;517;516;515;514;513;512;509;506;505;504;200;201;238;237;234;312;556;199;22;585;Parallax Mapping;1,0,0.1448274,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;638;-2532.528,1929.456;Float;False;Constant;_Float8;Float 8;-1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;446;-2034.677,-853.6917;Float;False;2453.801;638.5608;Comment;26;424;420;429;432;423;425;422;436;435;428;439;437;421;434;431;426;433;427;430;438;78;486;488;489;704;705;Base Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;605;403.6526,2545.701;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;372;-2204.97,1288.611;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;410;-1711.798,10.59547;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;641;-2267.408,1726.475;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;504;-6625.002,-805.8302;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;695;2367.512,3134.411;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;614;-799.3287,2953.52;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;371;-2204.122,1436.7;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;445;-2311.837,-1315.142;Float;False;788.9907;361.0603;Comment;5;440;441;442;443;444;Indirect Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-530.0884,1076.115;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;476;-1433.236,-2114.092;Float;False;1940.988;1036.867;Comment;26;457;458;459;460;461;463;464;455;454;456;465;468;469;470;251;288;473;359;406;97;307;474;626;627;628;654;Spec/AO;1,1,1,1;0;0
Node;AmplifyShaderEditor.ExpOpNode;642;-2195.308,1632.65;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;-1931.727,-780.0047;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;651;-2536.957,2023.41;Float;False;Property;_Layer2BlendWeight;Layer2 Blend Weight;41;0;Create;True;0;0;False;0;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;245;1259.82,-1672.023;Float;False;1237.274;282.8428;Comment;6;240;243;242;244;241;487;Toon Ramp;1,0.5808823,0.5808823,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;421;-1984.677,-672.2946;Float;False;Property;_BaseCellOffset;Base Cell Offset;6;0;Create;True;0;0;False;0;0.5;0.49;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;423;-1727.66,-522.6866;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;416;-1536.245,18.00416;Float;False;UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);4;False;1;True;reflVect;FLOAT3;0,0,0;In;;Float;UNITY_SAMPLE_TEXCUBE_LOD;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-5563.383,-46.04471;Float;False;Property;_BaseScrollRotate;Base Scroll/Rotate;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;1309.819,-1514.798;Float;False;Constant;_WrapperValue;Wrapper Value;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;444;-2261.836,-1170.825;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;288;-1408.916,-1511.905;Float;False;Property;_OcculusionStrength;Occulusion Strength;44;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;694;2616.461,3265.796;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;424;-1701.228,-779.1197;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;556;-5907.212,-299.6359;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;31;-370.0886,1076.115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;361;-2051.961,1405.894;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;643;-2056.598,1626.109;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;238;-5512.092,28.94523;Float;False;Property;_BaseRotationPosition;Base Rotation Position;5;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;422;-1682.601,-682.6076;Float;False;Property;_BaseCellSharpness;Base Cell Sharpness;7;0;Create;True;0;0;False;0;1;1;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;1346.268,-1622.022;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;345;1374.878,1578.738;Float;False;1248.516;345.7109;Comment;8;351;347;344;341;343;342;340;339;Matcap;0.6965518,1,0,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;606;588.6528,2545.701;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;234;-5824.911,-123.966;Float;False;Property;_BaseSpeedXY;Base Speed(X/Y);4;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;615;269.5321,2890.57;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;251;-1402.881,-1706.529;Float;True;Property;_OcculusionMap;Occulusion Map;43;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Occulusion);None;be1964b4792f30143a4b8d2261c448b8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;612;722.9048,2647.031;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;351;1393.032,1730.865;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;607;722.6537,2545.701;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;425;-1402.163,-775.2757;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;442;-2047.275,-1069.081;Float;False;Property;_IndirectDiffuseContribution;Indirect Diffuse Contribution;8;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;426;-1414.633,-497.5506;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;703;2735.984,3183.477;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewMatrixNode;339;1429.768,1630.337;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-306.0886,1204.115;Float;False;Property;_RimPower;Rim Power;27;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;440;-1921.657,-1265.142;Float;False;Constant;_Float0;Float 0;20;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;441;-2018.211,-1169.166;Float;False;World;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;415;-1205.227,124.3092;Float;False;Constant;_Float7;Float 7;0;0;Create;True;0;0;False;0;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;312;-5203.62,-130.6231;Float;False;UVMove;-1;;71;76d828458def6914aae3d4d31eea21e6;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;654;-1094.926,-1617.83;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;32;-194.089,1076.115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;454;-1383.236,-1383.571;Float;False;Blinn-Phong Half Vector;-1;;70;91a149ac9d615be429126c95e20753ce;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;455;-1355.325,-1295.427;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;649;-1904.837,1512.158;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;413;-1200.746,22.30433;Float;False;DecodeHDR(val,unity_SpecCube0_HDR);3;False;1;True;val;FLOAT4;0,0,0,0;In;;Float;DecodeHDR;True;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;436;-1732.702,-413.8676;Float;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;409;-1356.723,-140.276;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;242;1530.847,-1621.158;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-238.7209,975.0118;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;243;1768.847,-1619.158;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;702;2127.247,2927.172;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;473;-860.7021,-1623.146;Float;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;611;905.9045,2521.031;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;341;1585.71,1768.546;Float;False;Constant;_Float3;Float 3;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;7.303577,1236.219;Float;False;Property;_RimColor;Rim Color;26;1;[HDR];Create;True;0;0;False;1;Header(Rim Light);1,1,1,0;0,0.6275859,1,0.377;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;435;-1224.089,-461.9166;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;199;-4500.007,-260.834;Float;True;Property;_Texture;Texture;0;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Texture);None;926cbb7bebd65bf4c9cb17e851196f1b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;1588.311,1660.123;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;412;-1016.427,33.10902;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;652;-1751.834,1485.536;Float;False;Property;_UseAnisotropic;Use Anisotropic;42;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;456;-1106.529,-1350.966;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;418;-1060.854,-67.02111;Float;False;ShadeSH9(half4(normal, 1.0));3;False;1;True;normal;FLOAT3;0,0,0;In;;Float;ShadeSH9;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;22;-4418.06,-73.2916;Float;False;Property;_BaseColor;Base Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;452;-414.1867,-89.53564;Float;False;692.999;308.7439;Comment;4;453;451;450;449;Light Falloff;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;622;900.1216,2690.175;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;465;-1154.327,-1221.449;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;432;-1244.71,-771.2457;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;37;-2.088512,1076.115;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;443;-1706.844,-1188.826;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;35;-12.86537,996.8718;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;437;-1203.3,-330.1317;Float;False;Property;_ShadowContribution;Shadow Contribution;11;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;428;-731.8086,-771.8327;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;282.0397,1004.889;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;449;-364.187,96.20881;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;701;2178.797,2783.408;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;468;-600.8153,-1491.741;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;240;1943.238,-1611.978;Float;True;Property;_ToonRamp;Toon Ramp;1;1;[NoScaleOffset];Create;True;0;0;False;0;None;ac638dfccf4899746a13f9a511c240bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;705;-739.1281,-631.3035;Float;False;Constant;_float9;float 9;89;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;450;-318.483,-39.53539;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.StaticSwitch;464;-922.8903,-1339.91;Float;False;Property;_StaticHighLights;Static HighLights;90;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;1737.96,1659.013;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;463;-911.0598,-1215.777;Float;False;Property;_HighlightCellOffset;Highlight Cell Offset;9;0;Create;True;0;0;False;0;-0.95;-0.5;-1;-0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;618;1114.01,2636.201;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;427;-1007.558,-772.3608;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;457;-578.075,-1212.659;Float;False;Property;_HighlightCellSharpness;Highlight Cell Sharpness;10;0;Create;True;0;0;False;0;0.01;1;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;38;291.1359,1244.297;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;549;-4125.729,-230.6748;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;360;-1453.035,1487.127;Float;False;Anisotropic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;506;-6247.99,-1040.403;Float;False;Property;_BackDepthScale;Back Depth Scale;21;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;512;-6065.642,-799.0472;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;505;-6336.045,-1038.782;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;509;-6278.333,-940.4644;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;482;-1467.329,-974.7518;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;411;-857.7386,-16.21838;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;434;-1034.212,-458.9316;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;515;-6243.475,-740.9323;Float;False;Property;_MidDepthScale;Mid Depth Scale;15;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;2260.62,-1596.733;Float;False;ToonRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;521;-5812.443,-618.9012;Float;False;Property;_MidSpeedXY;Mid Speed(X/Y);17;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;459;-260.6454,-1277.325;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;359;-1244.626,-1876.92;Float;False;Property;_SpecularTint;Specular Tint;36;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;513;-5565.415,-875.2133;Float;False;Property;_BackScrollRotate;Back Scroll/Rotate;22;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;516;-5842.916,-1094.343;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;567.9936,997.9408;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;517;-5822.313,-938.1423;Float;False;Property;_BackSpeedXY;Back Speed(X/Y);23;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;483;-464.7138,-931.7487;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;343;1871.018,1698.527;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ParallaxMappingNode;524;-5843.438,-778.9382;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-1050.379,-1794.107;Float;False;360;Anisotropic;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;523;-5458.459,-519.6808;Float;False;Property;_MidScrollRotate;Mid Scroll/Rotate;16;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;458;-586.9892,-1335.729;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;201;-3693.147,-231.0999;Float;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;522;-5202.744,-450.4095;Float;False;Property;_MidRotationPosition;Mid Rotation Position;18;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;514;-5186.962,-867.3712;Float;False;Property;_BackRotationPosition;Back Rotation Position;24;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StaticSwitch;700;2560.839,2701.503;Float;False;Property;_SSSType;SSS Type;45;0;Create;True;0;0;False;1;Header(Subsurface Scattering);0;0;0;True;;KeywordEnum;2;Simple;Advanced;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;451;-130.1889,26.62598;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;433;-651.5027,-456.8557;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;486;-422.6379,-220.1362;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;97;-1248.456,-2064.092;Float;True;Property;_SpecularMap;Specular Map;35;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Specular) ;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;704;-546.6892,-662.5627;Float;False;Property;_UseLightColor;Use Light Color;89;0;Create;True;0;0;False;0;0;1;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;430;-310.0771,-803.6927;Float;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;460;-85.21773,-1351.383;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;453;11.9375,19.55799;Float;False;LightColorFalloff;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;429;-307.7751,-579.3116;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;-771.3143,-1975.105;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;526;-4878.581,-622.5262;Float;False;UVMove;-1;;81;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;488;-330.9059,-378.1276;Float;False;487;ToonRamp;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;227;812.8864,969.3873;Float;False;Property;_UseRim;Use Rim;29;0;Create;True;0;0;False;1;Toggle;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;439;-308.0981,-471.0646;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;344;1990.724,1671.433;Float;True;Property;_Matcap;Matcap;12;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Matcap);None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;525;-4861.883,-1087.443;Float;False;UVMove;-1;;80;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;653;2801.578,2690.414;Float;False;Property;_UseSSS;Use SSS;55;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;461;130.666,-1347.671;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;619;3014.094,2693.264;Float;False;SSS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;78;-51.01545,-466.4866;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;536;-4457.546,-647.7723;Float;True;Property;_Mid;Mid;13;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Parallax Mapping) ;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;529;-4522.888,-879.7942;Float;False;Property;_BackColor;Back Color;20;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;489;-51.03115,-374.4096;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;431;-50.93155,-690.5676;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;470;35.61405,-1440.212;Float;False;453;LightColorFalloff;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;534;-4374.295,-446.5265;Float;False;Property;_MidColor;Mid Color;14;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;347;2294.717,1672.657;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;528;-4583.314,-1082.979;Float;True;Property;_Back;Back;19;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;626;-236.5804,-1497.396;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;474;-481.5893,-1809.779;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;296;1020.133,974.9568;Float;False;RimLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;58;1159.134,-1125.009;Float;False;1317.387;726.5446;Comment;7;336;496;495;59;62;63;60;Emissive Mask;0.6551723,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;621;271.0671,-975.0037;Float;False;619;SSS;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;628;51.41956,-1346.396;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;479;254.8194,-1050.25;Float;False;296;RimLight;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;655;499.9669,-694.5786;Float;False;347;Matcap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;67;-28.32075,1559.512;Float;False;1236.957;425.3915;Comment;8;303;75;73;72;71;69;68;593;Alpha Outline;0,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;542;-6045.284,-37.64188;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;469;338.751,-1511.399;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;537;-4271.037,-991.3673;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;541;-4061.765,-723.8652;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;420;277.4747,-681.7455;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;627;88.41956,-1265.396;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;477;520.0087,-975.1418;Float;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;548;-4495.307,184.4517;Float;True;Property;_Mask;Mask;25;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;547;-3743.892,-890.9492;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;63;1253.072,-708.3834;Float;False;Property;_EmissionColor;Emission Color;32;1;[HDR];Create;True;0;0;False;1;Header(Emission);0,0,0,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;68;34.79198,1701.554;Float;False;Property;_OutlineTint;Outline Tint;58;0;Create;True;0;0;False;1;Header(Outline) ;0.5294118,0.5294118,0.5294118,0;0.5294118,0.5294118,0.5294118,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;543;-4040.272,-1527.458;Float;True;Property;_RenderTexture;Render Texture;65;0;Create;True;0;0;False;1;Header(Render Texture);None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;1192.072,-532.3837;Float;False;Property;_EmissionIntensity;Emission Intensity;33;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;546;-3754.159,-726.4833;Float;False;Property;_ReflectionBlend;Reflection Blend;66;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;625;644.1937,-1025.247;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;70.55209,1607.754;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;69;338.4719,1703.795;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;551;-3567.313,-416.4206;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;59;1170.073,-898.384;Float;True;Property;_EmisionMask;Emision Mask;34;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;495;1671.163,-708.0303;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1253.072,-1092.382;Float;True;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;585;-4147.87,-125.4384;Float;False;OpacityMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;550;-3441.139,-955.5674;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;496;1942.667,-803.2592;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;554;-3140.431,-823.1952;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;568.3265,1616.795;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0.3382353,0.3382353,0.3382353;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;72;318.9788,1851.78;Float;False;Property;_OutlineWidth;Outline Width;59;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;484;785.8246,-1028.272;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;593;345.0402,1782.615;Float;False;585;OpacityMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;555;-2824.343,-848.6183;Float;False;Parallax;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;930.8013,-1028.975;Float;False;Lighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;2219.959,-808.4354;Float;True;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;253;1312.926,355.1303;Float;False;1618.157;923.3635;Comment;9;357;269;254;710;711;712;713;714;715;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.OutlineNode;75;763.8909,1657.573;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;254;1339.404,478.2882;Float;False;232;165;Comment;1;252;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;303;985.3972,1662.14;Float;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;1533.537,23.18257;Float;False;291;Lighting;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;1639.188,-369.9437;Float;False;336;Emissive;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;557;1642.611,-264.7245;Float;False;555;Parallax;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;498;-6594.148,-1703.182;Float;False;2099.11;524.8445;Get screen color for refraction and disturbe it with normals;13;533;527;520;519;518;511;510;508;507;503;502;501;499;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;269;1599.987,554.2058;Float;False;408.8691;641.6335;Comment;11;258;257;267;268;265;266;264;260;259;263;262;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;527;-4910.542,-1551.08;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;600;-96.02081,2625.586;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;598;-316.1288,2804.866;Float;False;SphereNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenColorNode;533;-4697.438,-1549.682;Float;False;Global;_GrabScreen0;Grab Screen 0;-1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;499;-6585.625,-1581.414;Float;False;Property;_DistortionTiling;Distortion Tiling;87;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;597;-561.0859,2810.191;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;267;1827.223,994.4182;Float;False;Property;_FailBack;Fail Back;76;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;264;1619.223,1074.418;Float;False;Property;_ZFailFront;ZFail Front;73;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SaturateNode;332;1771.591,27.53426;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;258;1619.223,674.4172;Float;False;Property;_ReadMask;Read Mask;68;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;262;1619.223,914.418;Float;False;Property;_PassFront;Pass Front;71;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;599;-301.9288,2682.387;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;602;76.15913,2623.811;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;259;1619.223,754.4173;Float;False;Property;_WriteMask;Write Mask;69;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;519;-5133.186,-1586.688;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;508;-6008.788,-1591.219;Float;True;Property;_TextureSample0;Texture Sample 0;63;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;603;30.00715,2480.031;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;-3697.062,-145.6836;Float;False;OutlineWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;586;1702.014,-54.7312;Float;False;585;OpacityMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;510;-5339.749,-1385.778;Float;False;Property;_Distortion;Distortion;84;0;Create;True;0;0;False;1;Header(Distortion);0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;712;2064.99,794.5095;Float;False;Property;_BlendOpRGB;Blend Op RGB;80;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendOp;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;302;1737.651,113.5638;Float;False;303;Outline;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;562;1862.74,-288.3978;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;507;-6007.362,-1380.767;Float;True;Property;_DitortionNormal;Ditortion Normal;85;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;604;253.6641,2545.708;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;518;-5668.481,-1474.33;Float;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;540;-3966.858,-1319.248;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GrabScreenPosition;511;-5436.533,-1643.822;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;357;1326.099,764.1531;Float;False;Property;_MaskClipValue;Mask Clip Value;56;0;Create;True;0;0;True;1;Header(Transparency);0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;502;-6241.801,-1400.583;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;265;1827.223,834.4178;Float;False;Property;_CompBack;Comp. Back;74;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;538;-4330.708,-1239.457;Float;False;Property;_DistortionBlend;Distortion Blend;86;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;260;1619.223,834.4178;Float;False;Property;_CompFront;Comp. Front;70;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;711;2063.427,693.6666;Float;False;Property;_BlendRGBDst;Blend RGB Dst;79;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;596;-791.8416,2806.641;Float;False;Object;World;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IntNode;268;1827.223,1074.418;Float;False;Property;_ZFailBack;ZFail Back;77;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;594;-397.7809,2522.633;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;714;2272.518,699.491;Float;False;Property;_BlendAlphaDst;Blend Alpha Dst;82;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;623;1634.038,-136.8675;Float;False;Property;_Opacity;Opacity;57;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;715;2277.081,796.3339;Float;False;Property;_BlendOpAlpha;Blend Op Alpha;83;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendOp;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;520;-5084.638,-1482.182;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;263;1619.223,994.4182;Float;False;Property;_FailFront;Fail Front;72;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;266;1827.223,914.418;Float;False;Property;_PassBack;Pass Back;75;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;1619.223,594.4175;Float;False;Property;_Reference;Reference;67;1;[IntRange];Create;True;0;0;True;1;Header(Stencil Buffer);0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;252;1383.839,528.1884;Float;False;Property;_CullMode;Cull Mode;88;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(Rendering);0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;713;2268.372,611.7039;Float;False;Property;_BlendAlphaSrc;Blend Alpha Src;81;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;503;-6244.103,-1513.082;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;501;-6498.802,-1485.784;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;10,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;710;2066.281,610.8796;Float;False;Property;_BlendRGBSrc;Blend RGB Src;78;1;[Enum];Create;True;0;1;UnityEngine.Rendering.BlendMode;True;1;Header(Blend);5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2034.541,-282.6825;Half;False;True;6;Half;CharacterShaderCustomInspector;100;0;CustomLighting;ASE/Character/CharacterToon;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;Transparent;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;True;0;True;257;255;True;258;255;True;259;0;True;260;0;True;262;0;True;263;0;True;264;0;True;265;0;True;266;0;True;267;0;True;268;True;0;1;1;5;True;0.0001;True;2;5;True;710;10;True;711;2;5;False;-1;10;False;-1;0;True;712;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;100;;-1;-1;-1;60;0;True;0;0;True;252;-1;0;True;357;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;661;0;659;0
WireConnection;661;1;601;0
WireConnection;662;0;660;0
WireConnection;662;1;661;0
WireConnection;664;0;662;0
WireConnection;665;0;663;0
WireConnection;665;1;664;0
WireConnection;668;0;667;2
WireConnection;670;0;667;2
WireConnection;670;1;669;0
WireConnection;45;5;44;0
WireConnection;666;0;665;0
WireConnection;666;1;668;0
WireConnection;656;0;666;0
WireConnection;656;1;670;0
WireConnection;46;0;45;0
WireConnection;657;0;656;0
WireConnection;657;1;608;0
WireConnection;387;0;385;0
WireConnection;387;1;386;0
WireConnection;48;0;46;0
WireConnection;680;0;667;2
WireConnection;658;0;657;0
WireConnection;658;1;609;0
WireConnection;51;0;48;0
WireConnection;392;0;391;0
WireConnection;388;0;387;0
WireConnection;679;0;680;0
WireConnection;681;0;674;0
WireConnection;672;0;610;1
WireConnection;672;1;658;0
WireConnection;672;2;671;0
WireConnection;394;0;392;0
WireConnection;394;1;388;0
WireConnection;682;0;679;0
WireConnection;676;0;675;0
WireConnection;676;1;681;0
WireConnection;673;0;672;0
WireConnection;395;0;394;0
WireConnection;381;0;383;0
WireConnection;381;1;380;0
WireConnection;398;0;400;0
WireConnection;398;1;397;0
WireConnection;683;0;682;0
WireConnection;687;0;675;0
WireConnection;689;0;679;0
WireConnection;677;0;676;0
WireConnection;382;0;381;0
WireConnection;404;0;395;0
WireConnection;399;0;398;0
WireConnection;688;0;673;0
WireConnection;376;0;395;0
WireConnection;376;1;382;0
WireConnection;678;0;673;0
WireConnection;678;1;677;0
WireConnection;678;2;683;0
WireConnection;686;0;687;0
WireConnection;686;1;688;0
WireConnection;686;2;689;0
WireConnection;686;3;684;0
WireConnection;377;0;395;0
WireConnection;377;1;399;0
WireConnection;402;0;403;0
WireConnection;402;1;404;0
WireConnection;690;0;678;0
WireConnection;690;1;686;0
WireConnection;630;0;377;0
WireConnection;630;1;644;0
WireConnection;646;0;402;0
WireConnection;375;0;377;0
WireConnection;375;1;378;0
WireConnection;629;0;376;0
WireConnection;629;1;645;0
WireConnection;374;0;376;0
WireConnection;374;1;379;0
WireConnection;632;0;629;0
WireConnection;632;1;629;0
WireConnection;364;0;374;0
WireConnection;364;1;374;0
WireConnection;633;0;630;0
WireConnection;633;1;630;0
WireConnection;692;0;690;0
WireConnection;692;1;691;0
WireConnection;362;0;375;0
WireConnection;362;1;375;0
WireConnection;647;0;646;0
WireConnection;635;0;647;0
WireConnection;635;1;631;0
WireConnection;693;0;692;0
WireConnection;365;0;362;0
WireConnection;365;1;364;0
WireConnection;634;0;633;0
WireConnection;634;1;632;0
WireConnection;366;0;402;0
WireConnection;366;1;363;0
WireConnection;52;0;50;0
WireConnection;52;1;49;0
WireConnection;636;0;634;0
WireConnection;636;1;635;0
WireConnection;699;0;693;0
WireConnection;367;0;365;0
WireConnection;367;1;366;0
WireConnection;53;0;52;0
WireConnection;29;0;27;0
WireConnection;29;1;26;0
WireConnection;696;0;617;0
WireConnection;698;0;699;0
WireConnection;417;0;408;0
WireConnection;417;1;414;0
WireConnection;640;0;636;0
WireConnection;640;1;637;0
WireConnection;370;0;367;0
WireConnection;370;1;368;0
WireConnection;605;0;608;0
WireConnection;372;0;370;0
WireConnection;410;0;417;0
WireConnection;641;0;639;0
WireConnection;641;1;638;0
WireConnection;695;0;696;0
WireConnection;695;1;697;0
WireConnection;695;2;698;0
WireConnection;614;0;595;0
WireConnection;371;0;390;0
WireConnection;371;1;369;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;642;0;640;0
WireConnection;416;0;410;0
WireConnection;694;0;695;0
WireConnection;694;1;697;2
WireConnection;694;2;690;0
WireConnection;424;0;438;0
WireConnection;424;1;421;0
WireConnection;556;0;504;0
WireConnection;31;0;30;0
WireConnection;361;0;372;0
WireConnection;361;1;371;0
WireConnection;643;0;642;0
WireConnection;643;1;641;0
WireConnection;643;2;651;0
WireConnection;606;0;605;0
WireConnection;606;1;609;0
WireConnection;615;0;614;0
WireConnection;612;0;615;0
WireConnection;607;0;606;0
WireConnection;425;0;424;0
WireConnection;425;1;422;0
WireConnection;426;0;423;0
WireConnection;703;0;694;0
WireConnection;441;0;444;0
WireConnection;312;1;556;0
WireConnection;312;2;234;0
WireConnection;312;3;237;0
WireConnection;312;4;238;0
WireConnection;654;0;251;0
WireConnection;654;1;288;0
WireConnection;32;0;31;0
WireConnection;649;0;361;0
WireConnection;649;1;643;0
WireConnection;413;0;416;0
WireConnection;242;0;241;0
WireConnection;242;1;244;0
WireConnection;242;2;244;0
WireConnection;243;0;242;0
WireConnection;702;0;703;0
WireConnection;473;0;654;0
WireConnection;611;0;610;1
WireConnection;611;1;607;0
WireConnection;611;2;612;0
WireConnection;435;0;426;0
WireConnection;435;1;436;2
WireConnection;199;1;312;0
WireConnection;340;0;339;0
WireConnection;340;1;351;0
WireConnection;412;0;413;0
WireConnection;412;1;415;0
WireConnection;652;0;649;0
WireConnection;456;0;454;0
WireConnection;456;1;455;0
WireConnection;418;0;409;0
WireConnection;622;0;617;0
WireConnection;432;0;425;0
WireConnection;37;0;32;0
WireConnection;37;1;33;0
WireConnection;443;0;440;0
WireConnection;443;1;441;0
WireConnection;443;2;442;0
WireConnection;35;0;34;0
WireConnection;39;0;35;0
WireConnection;39;1;37;0
WireConnection;701;0;702;0
WireConnection;468;0;473;0
WireConnection;240;1;243;0
WireConnection;464;1;456;0
WireConnection;464;0;465;0
WireConnection;342;0;340;0
WireConnection;342;1;341;0
WireConnection;618;0;611;0
WireConnection;618;1;622;0
WireConnection;427;0;432;0
WireConnection;427;1;423;0
WireConnection;38;0;36;0
WireConnection;549;0;199;0
WireConnection;549;1;22;0
WireConnection;360;0;652;0
WireConnection;512;0;504;0
WireConnection;505;0;504;0
WireConnection;482;0;443;0
WireConnection;411;0;418;0
WireConnection;411;1;412;0
WireConnection;434;0;435;0
WireConnection;487;0;240;0
WireConnection;459;0;468;0
WireConnection;459;1;457;0
WireConnection;516;0;505;0
WireConnection;516;2;506;0
WireConnection;516;3;509;0
WireConnection;42;0;39;0
WireConnection;42;1;38;0
WireConnection;483;0;482;0
WireConnection;343;0;342;0
WireConnection;343;1;341;0
WireConnection;524;0;512;0
WireConnection;524;2;515;0
WireConnection;524;3;509;0
WireConnection;458;0;464;0
WireConnection;458;1;463;0
WireConnection;201;0;549;0
WireConnection;700;1;618;0
WireConnection;700;0;701;0
WireConnection;451;0;450;1
WireConnection;451;1;449;0
WireConnection;433;0;434;0
WireConnection;433;1;427;0
WireConnection;433;2;437;0
WireConnection;486;0;411;0
WireConnection;704;1;705;0
WireConnection;704;0;428;1
WireConnection;430;0;483;0
WireConnection;430;1;428;2
WireConnection;430;2;434;0
WireConnection;430;3;486;0
WireConnection;460;0;458;0
WireConnection;460;1;459;0
WireConnection;453;0;451;0
WireConnection;429;0;704;0
WireConnection;429;1;433;0
WireConnection;307;0;97;0
WireConnection;307;1;359;0
WireConnection;307;2;406;0
WireConnection;526;1;524;0
WireConnection;526;2;521;0
WireConnection;526;3;523;0
WireConnection;526;4;522;0
WireConnection;227;0;42;0
WireConnection;344;1;343;0
WireConnection;525;1;516;0
WireConnection;525;2;517;0
WireConnection;525;3;513;0
WireConnection;525;4;514;0
WireConnection;653;0;700;0
WireConnection;461;0;460;0
WireConnection;619;0;653;0
WireConnection;78;0;439;0
WireConnection;536;1;526;0
WireConnection;489;0;488;0
WireConnection;431;0;430;0
WireConnection;431;1;429;0
WireConnection;347;0;344;0
WireConnection;528;1;525;0
WireConnection;626;0;473;0
WireConnection;474;0;307;0
WireConnection;296;0;227;0
WireConnection;628;0;626;0
WireConnection;542;0;504;0
WireConnection;469;0;474;0
WireConnection;469;1;470;0
WireConnection;469;2;461;0
WireConnection;537;0;528;0
WireConnection;537;1;529;0
WireConnection;541;0;536;0
WireConnection;541;1;534;0
WireConnection;420;0;431;0
WireConnection;420;1;78;0
WireConnection;420;2;489;0
WireConnection;627;0;628;0
WireConnection;477;0;469;0
WireConnection;477;1;479;0
WireConnection;477;2;621;0
WireConnection;477;3;420;0
WireConnection;477;4;655;0
WireConnection;548;1;542;0
WireConnection;547;0;537;0
WireConnection;547;1;541;0
WireConnection;547;2;536;4
WireConnection;625;0;627;0
WireConnection;625;1;477;0
WireConnection;69;0;68;0
WireConnection;551;0;548;1
WireConnection;495;0;63;0
WireConnection;495;1;62;0
WireConnection;585;0;199;4
WireConnection;550;0;543;0
WireConnection;550;1;547;0
WireConnection;550;2;546;0
WireConnection;496;0;60;0
WireConnection;496;1;59;0
WireConnection;496;2;495;0
WireConnection;554;0;550;0
WireConnection;554;1;549;0
WireConnection;554;2;551;0
WireConnection;73;0;71;0
WireConnection;73;1;69;0
WireConnection;484;0;625;0
WireConnection;555;0;554;0
WireConnection;291;0;484;0
WireConnection;336;0;496;0
WireConnection;75;0;73;0
WireConnection;75;2;593;0
WireConnection;75;1;72;0
WireConnection;303;0;75;0
WireConnection;527;0;519;0
WireConnection;527;1;520;0
WireConnection;600;0;594;0
WireConnection;600;1;599;0
WireConnection;598;0;597;0
WireConnection;533;0;527;0
WireConnection;597;0;596;0
WireConnection;332;0;293;0
WireConnection;599;0;597;0
WireConnection;599;1;601;0
WireConnection;602;0;600;0
WireConnection;519;0;511;0
WireConnection;508;1;503;0
WireConnection;200;0;585;0
WireConnection;562;0;337;0
WireConnection;562;1;557;0
WireConnection;507;1;502;0
WireConnection;604;0;603;0
WireConnection;604;1;602;0
WireConnection;518;0;508;0
WireConnection;518;1;507;0
WireConnection;540;0;533;0
WireConnection;540;1;537;0
WireConnection;540;2;538;0
WireConnection;502;0;501;0
WireConnection;596;0;595;0
WireConnection;520;0;518;0
WireConnection;520;1;510;0
WireConnection;503;0;501;0
WireConnection;501;0;499;0
WireConnection;0;2;562;0
WireConnection;0;9;623;0
WireConnection;0;10;586;0
WireConnection;0;13;332;0
WireConnection;0;11;302;0
ASEEND*/
//CHKSM=DBCFDAD7B0F789C0A4D5608420A4975AC8478C34