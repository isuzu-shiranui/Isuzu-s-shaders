// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/Character/CharacterToon"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[NoScaleOffset][Header(Texture)]_Texture("Texture", 2D) = "white" {}
		_BaseCellSharpness("Base Cell Sharpness", Range( 0.01 , 1)) = 1
		[NoScaleOffset]_ToonRamp("Toon Ramp", 2D) = "white" {}
		_IndirectDiffuseContribution("Indirect Diffuse Contribution", Range( 0 , 1)) = 1
		_BaseCellOffset("Base Cell Offset", Range( -1 , 1)) = 0.5
		[HDR]_BaseColor("Base Color", Color) = (1,1,1,0)
		_BaseScrollRotate("Base Scroll/Rotate", Range( 0 , 1)) = 0
		_HighlightCellOffset("Highlight Cell Offset", Range( -1 , -0.5)) = -0.95
		_ShadowContribution("Shadow Contribution", Range( 0 , 1)) = 0.5
		_HighlightCellSharpness("Highlight Cell Sharpness", Range( 0.001 , 1)) = 0.01
		_BaseSpeedXY("Base Speed(X/Y)", Vector) = (0,0,0,0)
		_BaseRotationPosition("Base Rotation Position", Vector) = (0,0,0,0)
		[Toggle(_STATICHIGHLIGHTS_ON)] _StaticHighLights("Static HighLights", Float) = 0
		[Header(Anisotropic)]_AnisotropyX("Anisotropy X", Range( 0 , 1)) = 1
		_AnisotropyY("Anisotropy Y", Range( 0 , 1)) = 1
		[HDR]_RimColor("Rim Color", Color) = (1,1,1,0)
		_RimPower("Rim Power", Range( 0 , 1)) = 1
		_RimOffset("Rim Offset", Range( 0 , 1)) = 1
		[Toggle][Toggle(_USERIM_ON)] _UseRim("Use Rim", Float) = 0
		[Normal][NoScaleOffset][Header(Normal) ]_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 10)) = 1
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionIntensity("Emission Intensity", Range( 0 , 1)) = 1
		[NoScaleOffset]_EmisionMask("Emision Mask", 2D) = "gray" {}
		[Header(Outline) ]_OutlineTint("Outline Tint", Color) = (0.5294118,0.5294118,0.5294118,0)
		_OutlineWidth("Outline Width", Range( 0 , 0.2)) = 0
		[NoScaleOffset][Header(Specular) ]_SpecularMap("Specular Map", 2D) = "black" {}
		_SpecularTint("Specular Tint", Color) = (0,0,0,0)
		[NoScaleOffset][Header(Occulusion)]_OcculusionMap("Occulusion Map", 2D) = "white" {}
		_OcculusionStrength("Occulusion Strength", Range( 0 , 10)) = 1
		[IntRange]_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0
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
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 1
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
			half4 tex2DNode199 = tex2Dlod( _Texture, half4( lerpResult10_g48, 0, 0.0) );
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
			half4 tex2DNode199 = tex2D( _Texture, lerpResult10_g48 );
			float4 Diffuse201 = ( _BaseColor * tex2DNode199 );
			o.Emission = ( Diffuse201 * half4( (_OutlineTint).rgb , 0.0 ) ).rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "LODFading" "IsEmissive" = "true"  }
		LOD 100
		Cull [_CullMode]
		ZWrite On
		Offset  0 , 0
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
		Blend One Zero , SrcAlpha OneMinusSrcAlpha
		BlendOp Add , Add
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Tessellation.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#pragma shader_feature _STATICHIGHLIGHTS_ON
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
			half2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
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

		uniform int _FailBack;
		uniform int _ZFailBack;
		uniform half _ReadMask;
		uniform half _MaskClipValue;
		uniform int _PassBack;
		uniform half _Reference;
		uniform int _ZFailFront;
		uniform int _CullMode;
		uniform int _CompBack;
		uniform half _WriteMask;
		uniform int _FailFront;
		uniform int _CompFront;
		uniform int _PassFront;
		uniform half4 _BaseColor;
		uniform sampler2D _Texture;
		uniform half2 _BaseSpeedXY;
		uniform half2 _BaseRotationPosition;
		uniform half _BaseScrollRotate;
		uniform sampler2D _EmisionMask;
		uniform half4 _EmissionColor;
		uniform half _EmissionIntensity;
		uniform sampler2D _SpecularMap;
		uniform half4 _SpecularTint;
		uniform half _NormalScale;
		uniform sampler2D _Normal;
		uniform half _AnisotropyX;
		uniform half _AnisotropyY;
		uniform sampler2D _OcculusionMap;
		uniform half _OcculusionStrength;
		uniform half _HighlightCellOffset;
		uniform half _HighlightCellSharpness;
		uniform half _RimOffset;
		uniform half _RimPower;
		uniform half4 _RimColor;
		uniform half _IndirectDiffuseContribution;
		uniform half _BaseCellOffset;
		uniform half _BaseCellSharpness;
		uniform half _ShadowContribution;
		uniform sampler2D _ToonRamp;
		uniform half _TessValue;
		uniform half _TessMin;
		uniform half _TessMax;
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
			float2 temp_output_2_0_g48 = _BaseSpeedXY;
			float2 temp_output_1_0_g48 = i.uv_texcoord;
			float2 panner6_g48 = ( _Time.x * temp_output_2_0_g48 + temp_output_1_0_g48);
			float cos5_g48 = cos( ( _Time.x * (temp_output_2_0_g48).x ) );
			float sin5_g48 = sin( ( _Time.x * (temp_output_2_0_g48).x ) );
			float2 rotator5_g48 = mul( temp_output_1_0_g48 - _BaseRotationPosition , float2x2( cos5_g48 , -sin5_g48 , sin5_g48 , cos5_g48 )) + _BaseRotationPosition;
			float2 lerpResult10_g48 = lerp( panner6_g48 , rotator5_g48 , _BaseScrollRotate);
			half4 tex2DNode199 = tex2D( _Texture, lerpResult10_g48 );
			float4 Diffuse201 = ( _BaseColor * tex2DNode199 );
			float2 uv_SpecularMap97 = i.uv_texcoord;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
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
			float Anisotropic360 = ( exp( ( ( ( ( temp_output_375_0 * temp_output_375_0 ) + ( temp_output_374_0 * temp_output_374_0 ) ) / ( dotResult402 + 1.0 ) ) * -2.0 ) ) * max( NdotL53 , 0.0 ) );
			float2 uv_OcculusionMap251 = i.uv_texcoord;
			float temp_output_473_0 = (( tex2D( _OcculusionMap, uv_OcculusionMap251 ) * _OcculusionStrength )).r;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 LightColorFalloff453 = ( ase_lightColor.rgb * ase_lightAtten );
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult4_g51 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult456 = dot( normalizeResult4_g51 , NormalDirection51 );
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
			half3 temp_cast_2 = (1.0).xxx;
			UnityGI gi441 = gi;
			float3 diffNorm441 = NormalDirection51;
			gi441 = UnityGI_Base( data, 1, diffNorm441 );
			float3 indirectDiffuse441 = gi441.indirect.diffuse + diffNorm441 * 0.0001;
			float3 lerpResult443 = lerp( temp_cast_2 , indirectDiffuse441 , _IndirectDiffuseContribution);
			float temp_output_434_0 = ( 1.0 - ( ( 1.0 - ase_lightAtten ) * _WorldSpaceLightPos0.w ) );
			float3 normal418 = half3(0,1,0);
			float3 localShadeSH9418 = ShadeSH9418( normal418 );
			float4 transform414 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult410 = normalize( ( half4( _WorldSpaceCameraPos , 0.0 ) - transform414 ) );
			float3 reflVect416 = normalizeResult410.xyz;
			float4 localUNITY_SAMPLE_TEXCUBE_LOD416 = UNITY_SAMPLE_TEXCUBE_LOD416( reflVect416 );
			float4 val413 = localUNITY_SAMPLE_TEXCUBE_LOD416;
			float3 localDecodeHDR413 = DecodeHDR413( val413 );
			float lerpResult433 = lerp( temp_output_434_0 , ( saturate( ( ( NdotL53 + _BaseCellOffset ) / _BaseCellSharpness ) ) * ase_lightAtten ) , _ShadowContribution);
			half2 temp_cast_5 = (saturate( (NdotL53*0.5 + 0.5) )).xx;
			float4 ToonRamp487 = tex2D( _ToonRamp, temp_cast_5 );
			float3 Lighting291 = saturate( ( ( (( tex2D( _SpecularMap, uv_SpecularMap97 ) * _SpecularTint * Anisotropic360 )).rgb * temp_output_473_0 * LightColorFalloff453 * saturate( ( ( staticSwitch464 + _HighlightCellOffset ) / ( ( 1.0 - temp_output_473_0 ) * _HighlightCellSharpness ) ) ) ) + RimLight296 + ( ( ( lerpResult443 * ase_lightColor.a * temp_output_434_0 * ( localShadeSH9418 + ( localDecodeHDR413 * 0.02 ) ) ) + ( ase_lightColor.rgb * lerpResult433 ) ) * (Diffuse201).rgb * (ToonRamp487).rgb ) ) );
			c.rgb = saturate( Lighting291 );
			c.a = 1;
			clip( (Diffuse201).a - _MaskClipValue );
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
			half4 tex2DNode199 = tex2D( _Texture, lerpResult10_g48 );
			float4 Diffuse201 = ( _BaseColor * tex2DNode199 );
			float4 temp_output_197_0 = Diffuse201;
			o.Albedo = temp_output_197_0.rgb;
			float2 uv_EmisionMask59 = i.uv_texcoord;
			float4 Emissive336 = ( Diffuse201 * tex2D( _EmisionMask, uv_EmisionMask59 ) * ( _EmissionColor * _EmissionIntensity ) );
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
	CustomEditor "IsuzuShader.Editor.CharacterShaderCustomInspector"
}
/*ASEBEGIN
Version=16100
0;92;1446;655;1195.579;1426.489;3.779121;False;False
Node;AmplifyShaderEditor.CommentaryNode;43;-237.466,509.6753;Float;False;1370.182;280;Comment;5;51;48;46;45;44;Normals;0.5220588,0.6044625,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-187.4669,586.185;Float;False;Property;_NormalScale;Normal Scale;21;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;405;-4872.491,501.0315;Float;False;3641.45;1372.962;Comment;28;401;396;393;389;384;390;369;378;379;374;366;372;377;375;363;362;371;376;361;360;365;364;368;370;367;402;404;403;Anisotropic;0.3054767,0.2132353,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;45;144.1393,558.6755;Float;True;Property;_Normal;Normal;20;2;[Normal];[NoScaleOffset];Create;True;0;0;False;1;Header(Normal) ;None;755e1253e335e0244b08d68af55727a3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;46;462.9224,564.9155;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;389;-4822.491,1515.395;Float;False;645.5051;342.6;View Direction Vector;4;386;385;388;387;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;48;704.5572,563.972;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;386;-4728.095,1694.995;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;385;-4799.492,1555.395;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;393;-4721.581,1231.973;Float;False;519.6584;229;Light Direction Vector;2;392;391;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;384;-4070.036,908.2327;Float;False;671.0317;332.7919;Binormal Direction Vector;4;380;382;381;383;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;889.713,565.423;Float;False;NormalDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;391;-4671.581,1281.973;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;387;-4508.289,1590.096;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;401;-4050.591,551.0316;Float;False;641.8149;319.6046;Tangent Direction Vector;4;397;398;399;400;;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexBinormalNode;397;-3978.371,691.6356;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexTangentNode;380;-3951.892,1062.025;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;383;-4020.034,958.2328;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;388;-4361.987,1590.196;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;392;-4386.923,1291.741;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;400;-4000.59,601.0315;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;396;-3776.851,1317.071;Float;False;370.698;183;Halfway Vector;2;394;395;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CrossProductOpNode;381;-3741.743,991.3549;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;394;-3726.851,1367.071;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;398;-3762.375,637.2365;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;399;-3593.775,662.6367;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;382;-3584.002,1029.924;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;395;-3591.153,1371.649;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;47;-1139.175,505.9388;Float;False;835.6508;341.2334;Comment;4;53;52;50;49;N dot L;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;481;-2452.993,-2792.167;Float;False;3541.816;2618.809;Comment;11;291;484;477;479;483;482;452;476;445;446;419;Custom Toon;0.7793103,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;379;-3160.942,1320.573;Float;False;Property;_AnisotropyY;Anisotropy Y;15;0;Create;True;0;0;False;0;1;0.083;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;378;-3124.642,1064.272;Float;False;Property;_AnisotropyX;Anisotropy X;14;0;Create;True;0;0;False;1;Header(Anisotropic);1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;377;-3026.244,935.8718;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;376;-3027.944,1152.473;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;419;-2365.065,-690.0132;Float;False;1609.518;484.417;Comment;11;408;409;410;411;412;413;414;415;416;417;418;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;49;-1095.027,691.5747;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;375;-2799.143,958.6719;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;403;-3331.622,1482.471;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;374;-2798.143,1220.673;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1062.117,555.9388;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1155.82,925.0117;Float;False;2380.421;525.8811;Comment;17;296;227;42;38;39;35;37;36;34;32;33;31;30;29;28;27;26;Rim Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;404;-3364.522,1532.771;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1105.82,1025.581;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;402;-3092.419,1522.771;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;364;-2567.332,1190.822;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;363;-2532.607,1382.559;Float;False;Constant;_Float4;Float 4;-1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;-2568.731,1061.001;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;26;-1058.789,1136.79;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;52;-764.8846,592.7377;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;408;-2315.065,-594.7116;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;414;-2251.53,-407.596;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;446;-2089.526,-1383.848;Float;False;2453.801;638.5608;Comment;24;424;420;429;432;423;425;422;436;435;428;439;437;421;434;431;426;433;427;430;438;78;486;488;489;Base Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;29;-753.6873,1071.898;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;365;-2379.332,1091.822;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;366;-2377.533,1255.621;Float;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-811.0862,1189.115;Float;False;Property;_RimOffset;Rim Offset;18;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;56;-544.471,-50.00652;Float;False;1693.978;482.7415;Comment;11;201;200;23;22;305;199;312;238;237;234;228;BaseColor;0,0.2965517,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;417;-1974.446,-490.8289;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-546.5259,596.0532;Float;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;238;-475.5052,304.8412;Float;False;Property;_BaseRotationPosition;Base Rotation Position;12;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;237;-500.0451,232.3482;Float;False;Property;_BaseScrollRotate;Base Scroll/Rotate;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;234;-437.5191,114.2262;Float;False;Property;_BaseSpeedXY;Base Speed(X/Y);11;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;476;-1497.211,-2528.656;Float;False;1940.988;1036.867;Comment;23;457;458;459;460;461;463;464;455;454;456;465;468;469;470;251;288;287;473;359;406;97;307;474;Spec/AO;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;368;-2217.632,1287.401;Float;False;Constant;_Float5;Float 5;-1;0;Create;True;0;0;False;0;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;367;-2221.432,1151.522;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;445;-2363.644,-1814.879;Float;False;788.9907;361.0603;Comment;5;440;441;442;443;444;Indirect Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;421;-2039.526,-1202.451;Float;False;Property;_BaseCellOffset;Base Cell Offset;5;0;Create;True;0;0;False;0;0.5;0.49;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;-1986.576,-1310.161;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-530.0884,1076.115;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;228;-458.147,-8.595718;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;410;-1763.605,-489.1419;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;245;-1888.865,30.26836;Float;False;1237.274;282.8428;Comment;6;240;243;242;244;241;487;Toon Ramp;1,0.5808823,0.5808823,1;0;0
Node;AmplifyShaderEditor.LightAttenuation;423;-1782.509,-1052.843;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;251;-1396.344,-2107.446;Float;True;Property;_OcculusionMap;Occulusion Map;29;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Occulusion);None;8ce2bdecc6f0ed046a875fe22ab67876;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;288;-1383.487,-1908.099;Float;False;Property;_OcculusionStrength;Occulusion Strength;30;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;422;-1737.45,-1212.764;Float;False;Property;_BaseCellSharpness;Base Cell Sharpness;2;0;Create;True;0;0;False;0;1;1;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;312;-151.7311,130.573;Float;False;UVMove;-1;;48;76d828458def6914aae3d4d31eea21e6;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;31;-370.0886,1076.115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;369;-2057.116,1469.003;Float;False;Constant;_Float6;Float 6;-1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;416;-1588.052,-481.7332;Float;False;UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);4;False;1;True;reflVect;FLOAT3;0,0,0;In;;Float;UNITY_SAMPLE_TEXCUBE_LOD;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;444;-2313.643,-1670.562;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;390;-2153.532,1384.197;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;-1838.866,187.4928;Float;False;Constant;_WrapperValue;Wrapper Value;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;424;-1756.077,-1309.276;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;370;-2066.332,1192.822;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;-2;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;-1802.417,80.26852;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;441;-2070.018,-1668.903;Float;False;World;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;425;-1457.012,-1306.432;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-194.089,1076.115;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;372;-1881.432,1195.722;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;371;-1897.072,1314.639;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;426;-1469.482,-1027.707;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;455;-1419.3,-1709.992;Float;False;51;NormalDirection;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-238.7209,975.0118;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;440;-1973.464,-1764.879;Float;False;Constant;_Float0;Float 0;20;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;436;-1787.551,-944.0234;Float;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;415;-1257.034,-375.4281;Float;False;Constant;_Float7;Float 7;0;0;Create;True;0;0;False;0;0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;442;-2099.082,-1568.818;Float;False;Property;_IndirectDiffuseContribution;Indirect Diffuse Contribution;4;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;413;-1252.553,-477.433;Float;False;DecodeHDR(val,unity_SpecCube0_HDR);3;False;1;True;val;FLOAT4;0,0,0,0;In;;Float;DecodeHDR;True;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;409;-1408.53,-640.0134;Float;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;287;-1061.861,-2025.101;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;454;-1447.211,-1798.135;Float;False;Blinn-Phong Half Vector;-1;;51;91a149ac9d615be429126c95e20753ce;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;199;165.8592,138.8557;Float;True;Property;_Texture;Texture;1;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Texture);None;af2ef591ec4040645a73f77356998088;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;242;-1617.838,81.13303;Float;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-306.0886,1204.115;Float;False;Property;_RimPower;Rim Power;17;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;418;-1112.661,-566.7585;Float;False;ShadeSH9(half4(normal, 1.0));3;False;1;True;normal;FLOAT3;0,0,0;In;;Float;ShadeSH9;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;412;-1068.234,-466.6283;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;452;-465.994,-589.273;Float;False;692.999;308.7439;Comment;4;453;451;450;449;Light Falloff;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;305;475.3661,233.2146;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;465;-1218.302,-1636.014;Float;False;53;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;443;-1758.651,-1688.563;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;22;498.3922,55.57234;Float;False;Property;_BaseColor;Base Color;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;456;-1170.504,-1765.53;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;473;-799.5748,-1989.944;Float;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;243;-1379.838,83.13301;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;435;-1278.938,-992.0723;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;35;-12.86537,996.8718;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;432;-1299.559,-1301.402;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;361;-1658.037,1195.183;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;37;-2.088512,1076.115;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;7.303577,1236.219;Float;False;Property;_RimColor;Rim Color;16;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0.377;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;434;-1089.061,-989.0874;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;457;-458.945,-1618.126;Float;False;Property;_HighlightCellSharpness;Highlight Cell Sharpness;10;0;Create;True;0;0;False;0;0.01;1;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;282.0397,1004.889;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;449;-415.9943,-403.5285;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;464;-986.8651,-1754.474;Float;False;Property;_StaticHighLights;Static HighLights;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;463;-852.207,-1630.342;Float;False;Property;_HighlightCellOffset;Highlight Cell Offset;8;0;Create;True;0;0;False;0;-0.95;-0.5;-1;-0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;360;-1474.037,1169.183;Float;True;Anisotropic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;411;-909.5459,-515.9557;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;427;-1062.407,-1302.517;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;482;-1519.136,-1474.489;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;38;291.1359,1244.297;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;796.7784,202.4439;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;450;-370.2903,-539.2728;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;240;-1205.445,90.31326;Float;True;Property;_ToonRamp;Toon Ramp;3;1;[NoScaleOffset];Create;True;0;0;False;0;None;52e66a9243cdfed44b5e906f5910d35b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;468;-457.8022,-1891.52;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;437;-1258.149,-860.2882;Float;False;Property;_ShadowContribution;Shadow Contribution;9;0;Create;True;0;0;False;0;0.5;0.004272614;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;201;942.8575,195.3789;Float;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;451;-181.9962,-473.1114;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;433;-706.3519,-987.0115;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-1312.431,-2478.656;Float;True;Property;_SpecularMap;Specular Map;27;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Specular) ;None;606cbbefdb8802741981879b86bfa366;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;406;-1114.354,-2208.671;Float;False;360;Anisotropic;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;459;-141.5155,-1624.79;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;428;-786.6578,-1301.989;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;458;-497.4291,-1758.254;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-888.0628,105.5578;Float;False;ToonRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;567.9936,997.9408;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;483;-516.5211,-1431.486;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;359;-1308.601,-2291.484;Float;False;Property;_SpecularTint;Specular Tint;28;0;Create;True;0;0;False;0;0,0,0,0;1,0.9117647,0.9117647,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;486;-477.487,-750.2923;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;439;-362.9472,-1001.221;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;488;-385.7551,-908.2834;Float;False;487;ToonRamp;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;227;812.8864,969.3873;Float;False;Property;_UseRim;Use Rim;19;0;Create;True;0;0;False;1;Toggle;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;430;-364.9262,-1333.849;Float;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;429;-362.6242,-1109.468;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;460;-149.1925,-1765.947;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;-835.2891,-2389.669;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;453;-39.86977,-480.1793;Float;False;LightColorFalloff;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;489;-105.8803,-904.5661;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;78;-105.8646,-996.6424;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;431;-105.7807,-1220.724;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;296;1020.133,974.9568;Float;False;RimLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;470;-28.36073,-1854.776;Float;False;453;LightColorFalloff;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;461;66.69126,-1762.235;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;67;-25.72071,1559.512;Float;False;1234.357;425.3915;Comment;9;303;75;74;73;72;71;70;69;68;Alpha Outline;1,0.6029412,0.7097364,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;474;-545.5641,-2224.343;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;68;34.79198,1701.554;Float;False;Property;_OutlineTint;Outline Tint;25;0;Create;True;0;0;False;1;Header(Outline) ;0.5294118,0.5294118,0.5294118,0;0.5294118,0.5294118,0.5294118,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;420;222.6256,-1211.902;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;469;274.7762,-1925.963;Float;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;200;543.4903,319.6241;Float;False;OutlineWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;479;201.1963,-1466.698;Float;False;296;RimLight;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;58;1159.134,-1125.009;Float;False;1317.387;726.5446;Comment;7;336;496;495;59;62;63;60;Emissive Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;287.5521,1613.754;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;477;484.2014,-1443.879;Float;True;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;326.0378,1904.497;Float;False;200;OutlineWidth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;69;338.4719,1703.795;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;63;1253.072,-708.3834;Float;False;Property;_EmissionColor;Emission Color;22;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;72;306.9788,1802.78;Float;False;Property;_OutlineWidth;Outline Width;26;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;1192.072,-532.3837;Float;False;Property;_EmissionIntensity;Emission Intensity;23;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;598.3265,1655.795;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0.3382353,0.3382353,0.3382353;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;495;1671.163,-708.0303;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;484;697.0173,-1443.009;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1253.072,-1092.382;Float;True;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;1170.073,-898.384;Float;True;Property;_EmisionMask;Emision Mask;24;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;649.3604,1807.849;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;860.994,-1443.712;Float;False;Lighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;496;1942.667,-803.2592;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;253;1300.577,515.6598;Float;False;724.3118;747.0767;Comment;3;269;254;357;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.OutlineNode;75;763.8909,1657.573;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1483.632,-309.8052;Float;False;201;Diffuse;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;336;2219.959,-808.4354;Float;True;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;345;1321.783,1376.976;Float;False;1248.516;345.7109;Comment;8;351;347;344;341;343;342;340;339;Future/Matcap;0.6965518,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;254;1330.143,604.8593;Float;False;232;165;Comment;1;252;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;303;985.3972,1662.14;Float;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;1337.537,-16.81743;Float;True;291;Lighting;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;269;1590.726,606.6865;Float;False;408.8691;641.6335;Comment;11;258;257;267;268;265;266;264;260;259;263;262;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;343;1817.923,1496.765;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;268;1817.961,1126.899;Float;False;Property;_ZFailBack;ZFail Back;42;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;264;1609.961,1126.899;Float;False;Property;_ZFailFront;ZFail Front;38;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;258;1609.961,726.8981;Float;False;Property;_ReadMask;Read Mask;33;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;347;2241.621,1470.895;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;267;1817.961,1046.899;Float;False;Property;_FailBack;Fail Back;41;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;357;1316.838,816.634;Float;False;Property;_MaskClipValue;Mask Clip Value;31;1;[IntRange];Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;266;1817.961,966.8989;Float;False;Property;_PassBack;Pass Back;40;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;1609.961,646.8983;Float;False;Property;_Reference;Reference;32;1;[IntRange];Create;True;0;0;True;0;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;252;1374.577,654.7596;Float;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;2;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;265;1817.961,886.8987;Float;False;Property;_CompBack;Comp. Back;39;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.SaturateNode;332;1575.591,-12.46574;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;341;1532.615,1566.784;Float;False;Constant;_Float3;Float 3;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;358;1777.331,-82.12642;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;302;1774.612,71.3972;Float;False;303;Outline;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;260;1609.961,886.8987;Float;False;Property;_CompFront;Comp. Front;35;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.ViewMatrixNode;339;1376.673,1428.575;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;259;1609.961,806.8982;Float;False;Property;_WriteMask;Write Mask;34;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;344;1937.629,1469.671;Float;True;Property;_Matcap;Matcap;43;1;[NoScaleOffset];Create;True;0;0;False;0;None;b23676ff9cac20a4c9c7b9333f055f1b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;263;1609.961,1046.899;Float;False;Property;_FailFront;Fail Front;37;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;1684.865,1457.251;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;1785.688,-212.6437;Float;False;336;Emissive;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;262;1609.961,966.8989;Float;False;Property;_PassFront;Pass Front;36;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;340;1535.216,1458.361;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;351;1339.937,1529.103;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2035.541,-279.6825;Half;False;True;6;Half;IsuzuShader.Editor.CharacterShaderCustomInspector;100;0;CustomLighting;ASE/Character/CharacterToon;False;False;False;False;False;False;False;False;False;False;False;False;False;LODFading;True;False;False;False;False;False;Off;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;Transparent;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;True;0;True;257;255;True;258;255;True;259;0;True;260;0;True;262;0;True;263;0;True;264;0;True;265;0;True;266;0;True;267;0;True;268;True;0;1;10;25;False;0.49;True;0;5;False;271;10;False;273;2;5;False;-1;10;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;100;;-1;-1;-1;44;0;True;0;0;True;252;-1;0;True;357;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;5;44;0
WireConnection;46;0;45;0
WireConnection;48;0;46;0
WireConnection;51;0;48;0
WireConnection;387;0;385;0
WireConnection;387;1;386;0
WireConnection;388;0;387;0
WireConnection;392;0;391;0
WireConnection;381;0;383;0
WireConnection;381;1;380;0
WireConnection;394;0;392;0
WireConnection;394;1;388;0
WireConnection;398;0;400;0
WireConnection;398;1;397;0
WireConnection;399;0;398;0
WireConnection;382;0;381;0
WireConnection;395;0;394;0
WireConnection;377;0;395;0
WireConnection;377;1;399;0
WireConnection;376;0;395;0
WireConnection;376;1;382;0
WireConnection;375;0;377;0
WireConnection;375;1;378;0
WireConnection;374;0;376;0
WireConnection;374;1;379;0
WireConnection;404;0;395;0
WireConnection;402;0;403;0
WireConnection;402;1;404;0
WireConnection;364;0;374;0
WireConnection;364;1;374;0
WireConnection;362;0;375;0
WireConnection;362;1;375;0
WireConnection;52;0;50;0
WireConnection;52;1;49;0
WireConnection;29;0;27;0
WireConnection;29;1;26;0
WireConnection;365;0;362;0
WireConnection;365;1;364;0
WireConnection;366;0;402;0
WireConnection;366;1;363;0
WireConnection;417;0;408;0
WireConnection;417;1;414;0
WireConnection;53;0;52;0
WireConnection;367;0;365;0
WireConnection;367;1;366;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;410;0;417;0
WireConnection;312;1;228;0
WireConnection;312;2;234;0
WireConnection;312;3;237;0
WireConnection;312;4;238;0
WireConnection;31;0;30;0
WireConnection;416;0;410;0
WireConnection;424;0;438;0
WireConnection;424;1;421;0
WireConnection;370;0;367;0
WireConnection;370;1;368;0
WireConnection;441;0;444;0
WireConnection;425;0;424;0
WireConnection;425;1;422;0
WireConnection;32;0;31;0
WireConnection;372;0;370;0
WireConnection;371;0;390;0
WireConnection;371;1;369;0
WireConnection;426;0;423;0
WireConnection;413;0;416;0
WireConnection;287;0;251;0
WireConnection;287;1;288;0
WireConnection;199;1;312;0
WireConnection;242;0;241;0
WireConnection;242;1;244;0
WireConnection;242;2;244;0
WireConnection;418;0;409;0
WireConnection;412;0;413;0
WireConnection;412;1;415;0
WireConnection;305;0;199;0
WireConnection;443;0;440;0
WireConnection;443;1;441;0
WireConnection;443;2;442;0
WireConnection;456;0;454;0
WireConnection;456;1;455;0
WireConnection;473;0;287;0
WireConnection;243;0;242;0
WireConnection;435;0;426;0
WireConnection;435;1;436;2
WireConnection;35;0;34;0
WireConnection;432;0;425;0
WireConnection;361;0;372;0
WireConnection;361;1;371;0
WireConnection;37;0;32;0
WireConnection;37;1;33;0
WireConnection;434;0;435;0
WireConnection;39;0;35;0
WireConnection;39;1;37;0
WireConnection;464;1;456;0
WireConnection;464;0;465;0
WireConnection;360;0;361;0
WireConnection;411;0;418;0
WireConnection;411;1;412;0
WireConnection;427;0;432;0
WireConnection;427;1;423;0
WireConnection;482;0;443;0
WireConnection;38;0;36;0
WireConnection;23;0;22;0
WireConnection;23;1;305;0
WireConnection;240;1;243;0
WireConnection;468;0;473;0
WireConnection;201;0;23;0
WireConnection;451;0;450;1
WireConnection;451;1;449;0
WireConnection;433;0;434;0
WireConnection;433;1;427;0
WireConnection;433;2;437;0
WireConnection;459;0;468;0
WireConnection;459;1;457;0
WireConnection;458;0;464;0
WireConnection;458;1;463;0
WireConnection;487;0;240;0
WireConnection;42;0;39;0
WireConnection;42;1;38;0
WireConnection;483;0;482;0
WireConnection;486;0;411;0
WireConnection;227;0;42;0
WireConnection;430;0;483;0
WireConnection;430;1;428;2
WireConnection;430;2;434;0
WireConnection;430;3;486;0
WireConnection;429;0;428;1
WireConnection;429;1;433;0
WireConnection;460;0;458;0
WireConnection;460;1;459;0
WireConnection;307;0;97;0
WireConnection;307;1;359;0
WireConnection;307;2;406;0
WireConnection;453;0;451;0
WireConnection;489;0;488;0
WireConnection;78;0;439;0
WireConnection;431;0;430;0
WireConnection;431;1;429;0
WireConnection;296;0;227;0
WireConnection;461;0;460;0
WireConnection;474;0;307;0
WireConnection;420;0;431;0
WireConnection;420;1;78;0
WireConnection;420;2;489;0
WireConnection;469;0;474;0
WireConnection;469;1;473;0
WireConnection;469;2;470;0
WireConnection;469;3;461;0
WireConnection;200;0;199;4
WireConnection;477;0;469;0
WireConnection;477;1;479;0
WireConnection;477;2;420;0
WireConnection;69;0;68;0
WireConnection;73;0;71;0
WireConnection;73;1;69;0
WireConnection;495;0;63;0
WireConnection;495;1;62;0
WireConnection;484;0;477;0
WireConnection;74;0;72;0
WireConnection;74;1;70;0
WireConnection;291;0;484;0
WireConnection;496;0;60;0
WireConnection;496;1;59;0
WireConnection;496;2;495;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;336;0;496;0
WireConnection;303;0;75;0
WireConnection;343;0;342;0
WireConnection;343;1;341;0
WireConnection;347;0;344;0
WireConnection;332;0;293;0
WireConnection;358;0;197;0
WireConnection;344;1;343;0
WireConnection;342;0;340;0
WireConnection;342;1;341;0
WireConnection;340;0;339;0
WireConnection;340;1;351;0
WireConnection;0;0;197;0
WireConnection;0;2;337;0
WireConnection;0;10;358;0
WireConnection;0;13;332;0
WireConnection;0;11;302;0
ASEEND*/
//CHKSM=4E60D50F28C34FB123560C18EF2B3357F690603E