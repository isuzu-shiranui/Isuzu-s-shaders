// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/Character/CharacterToon_Parallax"
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
		[NoScaleOffset][Header(Parallax Mapping) ]_Mid("Mid", 2D) = "white" {}
		[HDR]_MidColor("Mid Color", Color) = (1,1,1,1)
		_MidDepthScale("Mid Depth Scale", Range( 0 , 1)) = 0
		_MidScrollRotate("Mid Scroll/Rotate", Range( 0 , 1)) = 0
		_MidSpeedXY("Mid Speed(X/Y)", Vector) = (0,0,0,0)
		_MidRotationPosition("Mid Rotation Position", Vector) = (0,0,0,0)
		[NoScaleOffset]_Back("Back", 2D) = "white" {}
		[HDR]_BackColor("Back Color", Color) = (1,1,1,1)
		_BackDepthScale("Back Depth Scale", Range( 0 , 1)) = 0
		_BackScrollRotate("Back Scroll/Rotate", Range( 0 , 1)) = 0
		_BackSpeedXY("Back Speed(X/Y)", Vector) = (0,0,0,0)
		_BackRotationPosition("Back Rotation Position", Vector) = (0,0,0,0)
		[NoScaleOffset]_Mask("Mask", 2D) = "white" {}
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
		[NoScaleOffset][Header(Specular) ]_SpecularMap("Specular Map", 2D) = "black" {}
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
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 4
		_TessMin( "Tess Min Distance", Float ) = 10
		_TessMax( "Tess Max Distance", Float ) = 25
		[Header(Custom Toon)]_ShadowContribution("Shadow Contribution", Range( 0 , 1)) = 0.5
		_BaseCellOffset("Base Cell Offset", Range( -1 , 1)) = 0
		_BaseCellSharpness("Base Cell Sharpness", Range( 0.01 , 1)) = 0.01
		_IndirectDiffuseContribution("Indirect Diffuse Contribution", Range( 0 , 1)) = 1
		_IndirectSpecularContribution("Indirect Specular Contribution", Range( 0 , 1)) = 1
		_HighlightCellOffset("Highlight Cell Offset", Range( -1 , -0.5)) = -1
		_HighlightCellSharpness("Highlight Cell Sharpness", Range( 0 , 1)) = 0.5311803
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
			float2 temp_output_2_0_g33 = _BaseSpeedXY;
			float2 temp_output_1_0_g33 = v.texcoord.xy;
			float2 panner6_g33 = ( _Time.x * temp_output_2_0_g33 + temp_output_1_0_g33);
			float cos5_g33 = cos( ( _Time.x * (temp_output_2_0_g33).x ) );
			float sin5_g33 = sin( ( _Time.x * (temp_output_2_0_g33).x ) );
			float2 rotator5_g33 = mul( temp_output_1_0_g33 - _BaseRotationPosition , float2x2( cos5_g33 , -sin5_g33 , sin5_g33 , cos5_g33 )) + _BaseRotationPosition;
			float2 lerpResult10_g33 = lerp( panner6_g33 , rotator5_g33 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2Dlod( _Texture, float4( lerpResult10_g33, 0, 1.0) );
			float OutlineCustomWidth76 = tex2DNode135.a;
			float outlineVar = ( _OutlineWidth * OutlineCustomWidth76 );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 temp_output_2_0_g33 = _BaseSpeedXY;
			float2 temp_output_1_0_g33 = i.uv_texcoord;
			float2 panner6_g33 = ( _Time.x * temp_output_2_0_g33 + temp_output_1_0_g33);
			float cos5_g33 = cos( ( _Time.x * (temp_output_2_0_g33).x ) );
			float sin5_g33 = sin( ( _Time.x * (temp_output_2_0_g33).x ) );
			float2 rotator5_g33 = mul( temp_output_1_0_g33 - _BaseRotationPosition , float2x2( cos5_g33 , -sin5_g33 , sin5_g33 , cos5_g33 )) + _BaseRotationPosition;
			float2 lerpResult10_g33 = lerp( panner6_g33 , rotator5_g33 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2D( _Texture, lerpResult10_g33 );
			float4 temp_output_315_0 = ( tex2DNode135 * _BaseColor );
			float4 BaseColor66 = temp_output_315_0;
			o.Emission = ( BaseColor66 * float4( (_OutlineTint).rgb , 0.0 ) ).rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
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
			float3 viewDir;
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
		uniform int _FailFront;
		uniform float _Reference;
		uniform float _WriteMask;
		uniform int _ZFailFront;
		uniform int _CullMode;
		uniform int _ZFailBack;
		uniform int _FailBack;
		uniform int _PassFront;
		uniform float _ReadMask;
		uniform int _CompBack;
		uniform int _CompFront;
		uniform sampler2D _Texture;
		uniform float2 _BaseSpeedXY;
		uniform float2 _BaseRotationPosition;
		uniform float _BaseScrollRotate;
		uniform float4 _BaseColor;
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
		uniform sampler2D _Back;
		uniform float2 _BackSpeedXY;
		uniform float _BackDepthScale;
		uniform float2 _BackRotationPosition;
		uniform float _BackScrollRotate;
		uniform float4 _BackColor;
		uniform sampler2D _Mid;
		uniform float2 _MidSpeedXY;
		uniform float _MidDepthScale;
		uniform float2 _MidRotationPosition;
		uniform float _MidScrollRotate;
		uniform float4 _MidColor;
		uniform sampler2D _Mask;
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


		inline float3 ShadeSH911_g34( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		inline float4 UNITY_SAMPLE_TEXCUBE_LOD7_g34( float3 reflVect )
		{
			return UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
		}


		inline float3 DecodeHDR8_g34( float4 val )
		{
			return DecodeHDR(val,unity_SpecCube0_HDR);
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMin, _TessMax, _TessValue );
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 Outline427 = 0;
			v.vertex.xyz += Outline427;
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
			float temp_output_40_0_g34 = Ndot53;
			float temp_output_19_0_g34 = ase_lightAtten;
			float temp_output_30_0_g34 = ( 1.0 - ( ( 1.0 - temp_output_19_0_g34 ) * _WorldSpaceLightPos0.w ) );
			float lerpResult31_g34 = lerp( ( saturate( ( ( temp_output_40_0_g34 + _BaseCellOffset ) / _BaseCellSharpness ) ) * temp_output_19_0_g34 ) , temp_output_30_0_g34 , _ShadowContribution);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_cast_7 = (1.0).xxx;
			float3 temp_output_74_0_g34 = NewNormal51;
			UnityGI gi48_g34 = gi;
			float3 diffNorm48_g34 = temp_output_74_0_g34;
			gi48_g34 = UnityGI_Base( data, 1, diffNorm48_g34 );
			float3 indirectDiffuse48_g34 = gi48_g34.indirect.diffuse + diffNorm48_g34 * 0.0001;
			float3 lerpResult49_g34 = lerp( temp_cast_7 , indirectDiffuse48_g34 , _IndirectDiffuseContribution);
			float3 normal11_g34 = float3(0,1,0);
			float3 localShadeSH911_g34 = ShadeSH911_g34( normal11_g34 );
			float4 transform3_g34 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult6_g34 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform3_g34 ) );
			float3 reflVect7_g34 = normalizeResult6_g34.xyz;
			float4 localUNITY_SAMPLE_TEXCUBE_LOD7_g34 = UNITY_SAMPLE_TEXCUBE_LOD7_g34( reflVect7_g34 );
			float4 val8_g34 = localUNITY_SAMPLE_TEXCUBE_LOD7_g34;
			float3 localDecodeHDR8_g34 = DecodeHDR8_g34( val8_g34 );
			float3 Lighting435 = saturate( ( ( ( lerpResult31_g34 * ase_lightColor.rgb ) + ( ase_lightColor.a * lerpResult49_g34 * temp_output_30_0_g34 ) ) + ( localShadeSH911_g34 + ( localDecodeHDR8_g34 * 0.02 ) ) ) );
			float2 temp_cast_11 = (saturate( (Ndot53*0.5 + 0.5) )).xx;
			float4 ToonRamp430 = tex2D( _ToonRamp, temp_cast_11 );
			float2 temp_output_2_0_g31 = _BackSpeedXY;
			float2 Offset121 = ( ( 0.0 - 1 ) * i.viewDir.xy * _BackDepthScale ) + i.uv_texcoord;
			float2 temp_output_1_0_g31 = Offset121;
			float2 panner6_g31 = ( _Time.x * temp_output_2_0_g31 + temp_output_1_0_g31);
			float cos5_g31 = cos( ( _Time.x * (temp_output_2_0_g31).x ) );
			float sin5_g31 = sin( ( _Time.x * (temp_output_2_0_g31).x ) );
			float2 rotator5_g31 = mul( temp_output_1_0_g31 - _BackRotationPosition , float2x2( cos5_g31 , -sin5_g31 , sin5_g31 , cos5_g31 )) + _BackRotationPosition;
			float2 lerpResult10_g31 = lerp( panner6_g31 , rotator5_g31 , _BackScrollRotate);
			float2 temp_output_2_0_g32 = _MidSpeedXY;
			float2 Offset122 = ( ( 0.0 - 1 ) * i.viewDir.xy * _MidDepthScale ) + i.uv_texcoord;
			float2 temp_output_1_0_g32 = Offset122;
			float2 panner6_g32 = ( _Time.x * temp_output_2_0_g32 + temp_output_1_0_g32);
			float cos5_g32 = cos( ( _Time.x * (temp_output_2_0_g32).x ) );
			float sin5_g32 = sin( ( _Time.x * (temp_output_2_0_g32).x ) );
			float2 rotator5_g32 = mul( temp_output_1_0_g32 - _MidRotationPosition , float2x2( cos5_g32 , -sin5_g32 , sin5_g32 , cos5_g32 )) + _MidRotationPosition;
			float2 lerpResult10_g32 = lerp( panner6_g32 , rotator5_g32 , _MidScrollRotate);
			float4 tex2DNode128 = tex2D( _Mid, lerpResult10_g32 );
			float4 lerpResult142 = lerp( ( tex2D( _Back, lerpResult10_g31 ) * _BackColor ) , ( tex2DNode128 * _MidColor ) , tex2DNode128.a);
			float2 temp_output_2_0_g33 = _BaseSpeedXY;
			float2 temp_output_1_0_g33 = i.uv_texcoord;
			float2 panner6_g33 = ( _Time.x * temp_output_2_0_g33 + temp_output_1_0_g33);
			float cos5_g33 = cos( ( _Time.x * (temp_output_2_0_g33).x ) );
			float sin5_g33 = sin( ( _Time.x * (temp_output_2_0_g33).x ) );
			float2 rotator5_g33 = mul( temp_output_1_0_g33 - _BaseRotationPosition , float2x2( cos5_g33 , -sin5_g33 , sin5_g33 , cos5_g33 )) + _BaseRotationPosition;
			float2 lerpResult10_g33 = lerp( panner6_g33 , rotator5_g33 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2D( _Texture, lerpResult10_g33 );
			float4 temp_output_315_0 = ( tex2DNode135 * _BaseColor );
			float4 lerpResult143 = lerp( lerpResult142 , temp_output_315_0 , tex2D( _Mask, i.uv_texcoord ).r);
			float4 Parallax436 = lerpResult143;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult29 = dot( NewNormal51 , ase_worldViewDir );
			#ifdef _USERIM_ON
				float3 staticSwitch202 = ( ( saturate( Ndot53 ) * pow( ( 1.0 - saturate( ( dotResult29 + _RimOffset ) ) ) , _RimPower ) ) * (_RimColor).rgb );
			#else
				float3 staticSwitch202 = float3( 0,0,0 );
			#endif
			float3 RimLight429 = staticSwitch202;
			float2 uv_SpecularMap97 = i.uv_texcoord;
			float4 temp_output_23_0_g34 = ( tex2D( _SpecularMap, uv_SpecularMap97 ) * _Specular );
			float3 temp_output_65_0_g34 = (temp_output_23_0_g34).xyz;
			float3 temp_cast_14 = (1.0).xxx;
			float3 indirectNormal20_g34 = temp_output_74_0_g34;
			float2 uv_OcculusionMap333 = i.uv_texcoord;
			Unity_GlossyEnvironmentData g20_g34 = UnityGlossyEnvironmentSetup( temp_output_65_0_g34.x, data.worldViewDir, indirectNormal20_g34, float3(0,0,0));
			float3 indirectSpecular20_g34 = UnityGI_IndirectSpecular( data, ( tex2D( _OcculusionMap, uv_OcculusionMap333 ) * _OcculusionStrength ).r, indirectNormal20_g34, g20_g34 );
			float3 lerpResult67_g34 = lerp( temp_cast_14 , indirectSpecular20_g34 , _IndirectSpecularContribution);
			float3 SpecSmooth434 = ( saturate( ( ( temp_output_40_0_g34 + _HighlightCellOffset ) / ( _HighlightCellSharpness * ( 1.0 - temp_output_65_0_g34 ) ) ) ) + ( lerpResult67_g34 * temp_output_65_0_g34 * pow( temp_output_65_0_g34 , 1.5 ) ) );
			c.rgb = saturate( ( ( float4( Lighting435 , 0.0 ) * ToonRamp430 * Parallax436 ) + float4( RimLight429 , 0.0 ) + float4( SpecSmooth434 , 0.0 ) ) ).rgb;
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
			float2 temp_output_2_0_g33 = _BaseSpeedXY;
			float2 temp_output_1_0_g33 = i.uv_texcoord;
			float2 panner6_g33 = ( _Time.x * temp_output_2_0_g33 + temp_output_1_0_g33);
			float cos5_g33 = cos( ( _Time.x * (temp_output_2_0_g33).x ) );
			float sin5_g33 = sin( ( _Time.x * (temp_output_2_0_g33).x ) );
			float2 rotator5_g33 = mul( temp_output_1_0_g33 - _BaseRotationPosition , float2x2( cos5_g33 , -sin5_g33 , sin5_g33 , cos5_g33 )) + _BaseRotationPosition;
			float2 lerpResult10_g33 = lerp( panner6_g33 , rotator5_g33 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2D( _Texture, lerpResult10_g33 );
			float4 temp_output_315_0 = ( tex2DNode135 * _BaseColor );
			float4 BaseColor66 = temp_output_315_0;
			o.Albedo = BaseColor66.rgb;
			float2 uv_EmisionMask59 = i.uv_texcoord;
			float4 temp_output_2_0_g35 = tex2D( _EmisionMask, uv_EmisionMask59 );
			float4 lerpResult33_g35 = lerp( BaseColor66 , ( _EmissionColor * _EmissionIntensity ) , temp_output_2_0_g35);
			float4 Emissive437 = ( lerpResult33_g35 * temp_output_2_0_g35 );
			o.Emission = Emissive437.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

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
0;92;1459;467;8713.857;4935.816;8.910162;True;True
Node;AmplifyShaderEditor.CommentaryNode;43;-1207.306,240.4645;Float;False;1370.182;280;Comment;5;51;48;46;45;44;Normals;0.5220588,0.6044625,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1157.307,316.974;Float;False;Property;_NormalScale;Normal Scale;26;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-825.7009,289.4645;Float;True;Property;_Normal;Normal;25;2;[Normal];[NoScaleOffset];Create;True;0;0;False;1;Header(Normal) ;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;46;-506.9176,295.7046;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;48;-265.2831,294.761;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1912.256,619.5065;Float;False;2358.86;538.0436;Comment;17;429;202;38;36;42;39;37;35;33;34;32;31;30;29;28;27;26;Rim Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-80.12727,296.212;Float;False;NewNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;144;-3104.395,-2535.108;Float;False;3495.699;1551.024;Comment;38;436;121;66;76;143;315;142;311;314;136;137;135;303;128;312;134;313;299;309;264;307;308;301;215;260;211;122;271;266;218;223;231;117;120;116;404;118;115;Parallax Mapping;0.6617647,1,0.734077,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;26;-1815.225,831.2845;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;47;-1840.276,221.2947;Float;False;568.6508;283.2334;Comment;4;53;52;50;49;N dot L;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;115;-3054.395,-2202.335;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1862.256,720.0756;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1567.522,883.6096;Float;False;Property;_RimOffset;Rim Offset;23;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1785.218,270.2947;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;49;-1826.128,348.9307;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;29;-1510.123,766.3926;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;120;-2707.725,-2336.97;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;117;-2672.869,-2137.437;Float;False;Property;_MidDepthScale;Mid Depth Scale;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-2677.383,-2436.909;Float;False;Property;_BackDepthScale;Back Depth Scale;16;0;Create;True;0;0;False;0;0;0.066;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;118;-2495.036,-2195.552;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;404;-2765.438,-2435.288;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;52;-1592.985,297.0936;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;271;-1616.353,-2263.876;Float;False;Property;_BackRotationPosition;Back Rotation Position;19;0;Create;True;0;0;False;0;0,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;266;-1994.806,-2271.719;Float;False;Property;_BackScrollRotate;Back Scroll/Rotate;17;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1286.524,770.6096;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-1887.85,-1916.186;Float;False;Property;_MidScrollRotate;Mid Scroll/Rotate;11;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;211;-2251.707,-2334.648;Float;False;Property;_BackSpeedXY;Back Speed(X/Y);18;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ParallaxMappingNode;121;-2272.308,-2490.849;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;218;-2241.835,-2015.406;Float;False;Property;_MidSpeedXY;Mid Speed(X/Y);12;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ParallaxMappingNode;122;-2272.832,-2175.443;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;223;-1632.135,-1846.914;Float;False;Property;_MidRotationPosition;Mid Rotation Position;13;0;Create;True;0;0;False;0;0,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;31;-1126.524,770.6096;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1475.626,293.4092;Float;False;Ndot;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;215;-2280.837,-1503.506;Float;False;Property;_BaseSpeedXY;Base Speed(X/Y);6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;301;-2347.658,-1785.648;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;260;-1711.924,-1353.8;Float;False;Property;_BaseRotationPosition;Base Rotation Position;7;0;Create;True;0;0;False;0;0,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;307;-1291.276,-2483.949;Float;False;UVMove;-1;;31;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;318;-1006.206,-821.9435;Float;False;1196.03;374.5941;Comment;6;322;321;320;317;319;430;Toon Ramp;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;308;-1307.972,-2019.03;Float;False;UVMove;-1;;32;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;264;-2063.793,-1388.645;Float;False;Property;_BaseScrollRotate;Base Scroll/Rotate;5;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-950.5246,770.6096;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-2186.771,-822.2488;Float;False;1142.864;969.4596;Comment;12;432;431;290;335;97;98;14;333;334;433;434;435;Custom Toon;0.9034483,1,0,1;0;0
Node;AmplifyShaderEditor.ColorNode;312;-952.2808,-2276.3;Float;False;Property;_BackColor;Back Color;15;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;34;-995.1564,669.5066;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1062.524,898.6096;Float;False;Property;_RimPower;Rim Power;22;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;309;-1393.896,-1534.812;Float;False;UVMove;-1;;33;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;317;-984.2327,-608.43;Float;False;Constant;_WrapperValue;Wrapper Value;32;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-886.9379,-2044.277;Float;True;Property;_Mid;Mid;8;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Parallax Mapping) ;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;319;-975.2327,-738.43;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;299;-2474.677,-1434.146;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;134;-1012.707,-2479.485;Float;True;Property;_Back;Back;14;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;313;-803.687,-1843.031;Float;False;Property;_MidColor;Mid Color;9;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;37;-758.5241,770.6096;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;-770.0035,880.0252;Float;False;Property;_RimColor;Rim Color;21;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;334;-2132.882,42.12953;Float;False;Property;_OcculusionStrength;Occulusion Strength;35;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;135;-933.0338,-1632.092;Float;True;Property;_Texture;Texture;2;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Texture);None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;333;-2158,-147;Float;True;Property;_OcculusionMap;Occulusion Map;34;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Occulusion);None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;35;-769.301,691.3666;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-700.429,-2387.873;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-2146.696,-237.9567;Float;False;Property;_Specular;Specular;33;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;314;-863.512,-1413.267;Float;False;Property;_BaseColor;Base Color;4;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-491.1579,-2120.37;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;303;-924.6998,-1212.053;Float;True;Property;_Mask;Mask;20;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;320;-777.2325,-752.43;Float;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-2162.696,-435.9567;Float;True;Property;_SpecularMap;Specular Map;32;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Specular) ;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;433;-1834.379,-419.04;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-474.3959,699.3835;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;67;561.225,685.6907;Float;False;1229.267;423.921;Comment;9;427;75;74;73;69;72;70;71;68;Alpha Outline;1,0.6029412,0.7097364,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;38;-510.0246,812.0709;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;315;-555.121,-1627.179;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;335;-1836,-142;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;14;-2081.696,-512.9567;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;431;-2051.322,-687.4286;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;432;-2067.322,-599.4285;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;311;3.294243,-1812.925;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;321;-539.2328,-750.43;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;142;-173.2849,-2287.455;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;68;621.7382,827.7324;Float;False;Property;_OutlineTint;Outline Tint;30;0;Create;True;0;0;False;1;Header(Outline) ;0.5294118,0.5294118,0.5294118,0;0.5294118,0.5294118,0.5294118,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-221.2401,699.8897;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;-454.5785,-1260.68;Float;False;OutlineCustomWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;290;-1603.367,-580.1217;Float;True;CustomToon;53;;34;3d617e4dd05588d4eaea2c27e10e95bb;0;5;40;FLOAT;0;False;74;FLOAT3;0,0,0;False;19;FLOAT;0;False;23;FLOAT4;0,0,0,0;False;24;FLOAT;1;False;2;FLOAT3;72;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;322;-364.233,-729.43;Float;True;Property;_ToonRamp;Toon Ramp;3;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;143;20.84051,-2188.647;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-41.57281,-1621.201;Float;False;BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;912.9842,1030.675;Float;False;76;OutlineCustomWidth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;893.9251,928.9575;Float;False;Property;_OutlineWidth;Outline Width;31;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;69;925.4182,829.9733;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;58;524.0657,-1778.783;Float;False;850.2473;781.9943;Comment;6;209;63;62;60;437;59;Emissive Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;447;366.224,-912.5112;Float;False;817;542.92;Comment;9;448;446;445;444;443;442;441;440;439;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;874.4982,739.9326;Float;False;66;BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;436;179.79,-2190.204;Float;False;Parallax;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;435;-1249.379,-517.04;Float;False;Lighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;430;-54.30952,-728.5756;Float;False;ToonRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;202;4.495424,675.3683;Float;False;Property;_UseRim;Use Rim;24;0;Create;True;0;0;False;1;Toggle;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;434;-1244.379,-594.04;Float;False;SpecSmooth;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;429;231.4145,676.9834;Float;False;RimLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;440;443.0691,-785.0719;Float;False;430;ToonRamp;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;62;544.6745,-1118.818;Float;False;Property;_EmissionIntensity;Emission Intensity;28;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;1185.272,781.9734;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0.3382353,0.3382353,0.3382353;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;1236.306,934.0264;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;63;563.3035,-1303.6;Float;False;Property;_EmissionColor;Emission Color;27;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;60;551.6926,-1729.619;Float;True;66;BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;448;436.4292,-706.5179;Float;False;436;Parallax;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;528.8636,-1514.261;Float;True;Property;_EmisionMask;Emision Mask;29;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;439;435.6941,-862.5112;Float;False;435;Lighting;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;444;432.2241,-446.5913;Float;False;434;SpecSmooth;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OutlineNode;75;1350.837,783.7515;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;368;773.1215,-258.2847;Float;False;870.8054;842.2418;Comment;2;367;355;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;443;673.2241,-785.5912;Float;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;451.6952,-525.0372;Float;False;429;RimLight;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;209;891.1433,-1474.898;Float;True;EmissiveMask;-1;;35;8475a84330edb2b41933a47e12b3e1d8;0;4;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;367;865.2145,-178.3996;Float;False;232;165;Comment;1;340;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;437;1158.904,-1470.552;Float;False;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;449;-699.9937,-290.4463;Float;False;1297.319;395.4562;Comment;8;457;456;455;454;453;452;451;450;Matcap;0.6965518,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;445;843.2241,-681.5912;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;355;1159.863,-166.5215;Float;False;408.8691;641.6335;Comment;11;366;365;364;363;362;361;360;359;358;357;356;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;427;1576.701,787.3516;Float;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;455;-99.10071,-122.5374;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;363;1387.099,353.6899;Float;False;Property;_ZFailBack;ZFail Back;47;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;362;1387.099,273.6896;Float;False;Property;_FailBack;Fail Back;46;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;365;1179.099,353.6899;Float;False;Property;_ZFailFront;ZFail Front;43;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;340;907.7675,-117.2234;Float;False;Property;_CullMode;Cull Mode;1;1;[Enum];Create;True;3;Back;0;Front;1;Off;2;1;UnityEngine.Rendering.CullMode;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;1216.891,-713.1961;Float;False;437;Emissive;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;357;1179.099,113.69;Float;False;Property;_CompFront;Comp. Front;39;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;428;1201.276,-459.75;Float;False;427;Outline;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1205.146,-802.9537;Float;False;66;BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;359;1179.099,193.69;Float;False;Property;_PassFront;Pass Front;40;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;356;1179.099,-46.30968;Float;False;Property;_ReadMask;Read Mask;37;1;[IntRange];Create;True;0;0;True;0;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;361;1387.099,113.69;Float;False;Property;_CompBack;Comp. Back;44;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;456;65.12524,-150.5903;Float;True;Property;_Matcap;Matcap;42;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;450;-680.3928,-144.7124;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;454;-274.4098,-172.6145;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;358;1179.099,273.6896;Float;False;Property;_FailFront;Fail Front;41;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SaturateNode;446;980.2241,-675.5912;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;438.2262,-619.3201;Float;False;457;Matcap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;364;1387.099,193.69;Float;False;Property;_PassBack;Pass Back;45;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;360;1179.099,-126.3096;Float;False;Property;_Reference;Reference;36;1;[IntRange];Create;True;0;0;True;0;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;366;1179.099,33.69047;Float;False;Property;_WriteMask;Write Mask;38;1;[IntRange];Create;True;0;0;True;0;255;255;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;457;382.9752,-149.1094;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;452;-452.4788,-80.6853;Float;False;Constant;_Float3;Float 3;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewMatrixNode;451;-600.2048,-238.8464;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;453;-441.6619,-209.0603;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1427.004,-764.3619;Float;False;True;6;Float;IsuzuShader.Editor.CharacterShaderCustomInspector;0;0;CustomLighting;ASE/Character/CharacterToon_Parallax;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;True;0;True;360;255;True;356;255;True;366;0;True;357;0;True;359;0;True;358;0;True;365;0;True;361;0;True;364;0;True;362;0;True;363;True;0;4;10;25;False;0.5;True;0;5;True;354;10;True;347;2;5;False;-1;10;False;-1;0;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;48;0;True;0;0;True;340;-1;0;False;353;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;5;44;0
WireConnection;46;0;45;0
WireConnection;48;0;46;0
WireConnection;51;0;48;0
WireConnection;29;0;27;0
WireConnection;29;1;26;0
WireConnection;118;0;115;0
WireConnection;404;0;115;0
WireConnection;52;0;50;0
WireConnection;52;1;49;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;121;0;404;0
WireConnection;121;2;116;0
WireConnection;121;3;120;0
WireConnection;122;0;118;0
WireConnection;122;2;117;0
WireConnection;122;3;120;0
WireConnection;31;0;30;0
WireConnection;53;0;52;0
WireConnection;301;0;115;0
WireConnection;307;1;121;0
WireConnection;307;2;211;0
WireConnection;307;3;266;0
WireConnection;307;4;271;0
WireConnection;308;1;122;0
WireConnection;308;2;218;0
WireConnection;308;3;231;0
WireConnection;308;4;223;0
WireConnection;32;0;31;0
WireConnection;309;1;301;0
WireConnection;309;2;215;0
WireConnection;309;3;264;0
WireConnection;309;4;260;0
WireConnection;128;1;308;0
WireConnection;299;0;115;0
WireConnection;134;1;307;0
WireConnection;37;0;32;0
WireConnection;37;1;33;0
WireConnection;135;1;309;0
WireConnection;35;0;34;0
WireConnection;137;0;134;0
WireConnection;137;1;312;0
WireConnection;136;0;128;0
WireConnection;136;1;313;0
WireConnection;303;1;299;0
WireConnection;320;0;319;0
WireConnection;320;1;317;0
WireConnection;320;2;317;0
WireConnection;433;0;97;0
WireConnection;433;1;98;0
WireConnection;39;0;35;0
WireConnection;39;1;37;0
WireConnection;38;0;36;0
WireConnection;315;0;135;0
WireConnection;315;1;314;0
WireConnection;335;0;333;0
WireConnection;335;1;334;0
WireConnection;311;0;303;1
WireConnection;321;0;320;0
WireConnection;142;0;137;0
WireConnection;142;1;136;0
WireConnection;142;2;128;4
WireConnection;42;0;39;0
WireConnection;42;1;38;0
WireConnection;76;0;135;4
WireConnection;290;40;431;0
WireConnection;290;74;432;0
WireConnection;290;19;14;0
WireConnection;290;23;433;0
WireConnection;290;24;335;0
WireConnection;322;1;321;0
WireConnection;143;0;142;0
WireConnection;143;1;315;0
WireConnection;143;2;311;0
WireConnection;66;0;315;0
WireConnection;69;0;68;0
WireConnection;436;0;143;0
WireConnection;435;0;290;0
WireConnection;430;0;322;0
WireConnection;202;0;42;0
WireConnection;434;0;290;72
WireConnection;429;0;202;0
WireConnection;73;0;71;0
WireConnection;73;1;69;0
WireConnection;74;0;72;0
WireConnection;74;1;70;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;443;0;439;0
WireConnection;443;1;440;0
WireConnection;443;2;448;0
WireConnection;209;1;60;0
WireConnection;209;2;59;0
WireConnection;209;3;63;0
WireConnection;209;4;62;0
WireConnection;437;0;209;0
WireConnection;445;0;443;0
WireConnection;445;1;442;0
WireConnection;445;2;444;0
WireConnection;427;0;75;0
WireConnection;455;0;454;0
WireConnection;455;1;452;0
WireConnection;456;1;455;0
WireConnection;454;0;453;0
WireConnection;454;1;452;0
WireConnection;446;0;445;0
WireConnection;457;0;456;0
WireConnection;453;0;451;0
WireConnection;453;1;450;0
WireConnection;0;0;197;0
WireConnection;0;2;438;0
WireConnection;0;13;446;0
WireConnection;0;11;428;0
ASEEND*/
//CHKSM=1A2EDD994FB7FFD364D1A85242487737C4821303