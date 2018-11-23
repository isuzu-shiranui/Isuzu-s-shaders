// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASE/Character/CharacterToon_Parallax_DistReflex"
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
		[Header(Distortion)]_Distortion("Distortion", Float) = 0.5
		[NoScaleOffset][Normal]_DitortionNormal("Ditortion Normal", 2D) = "bump" {}
		_DistortionBlend("Distortion Blend", Range( 0 , 1)) = 1
		_DistortionTiling("Distortion Tiling", Float) = 1
		_RenderTexture("Render Texture", 2D) = "black" {}
		_ReflectionBlend("Reflection Blend", Range( 0 , 1)) = 1
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
			float2 temp_output_2_0_g42 = _BaseSpeedXY;
			float2 temp_output_1_0_g42 = v.texcoord.xy;
			float2 panner6_g42 = ( _Time.x * temp_output_2_0_g42 + temp_output_1_0_g42);
			float cos5_g42 = cos( ( _Time.x * (temp_output_2_0_g42).x ) );
			float sin5_g42 = sin( ( _Time.x * (temp_output_2_0_g42).x ) );
			float2 rotator5_g42 = mul( temp_output_1_0_g42 - _BaseRotationPosition , float2x2( cos5_g42 , -sin5_g42 , sin5_g42 , cos5_g42 )) + _BaseRotationPosition;
			float2 lerpResult10_g42 = lerp( panner6_g42 , rotator5_g42 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2Dlod( _Texture, float4( lerpResult10_g42, 0, 1.0) );
			float OutlineCustomWidth76 = tex2DNode135.a;
			float outlineVar = ( _OutlineWidth * OutlineCustomWidth76 );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 temp_output_2_0_g42 = _BaseSpeedXY;
			float2 temp_output_1_0_g42 = i.uv_texcoord;
			float2 panner6_g42 = ( _Time.x * temp_output_2_0_g42 + temp_output_1_0_g42);
			float cos5_g42 = cos( ( _Time.x * (temp_output_2_0_g42).x ) );
			float sin5_g42 = sin( ( _Time.x * (temp_output_2_0_g42).x ) );
			float2 rotator5_g42 = mul( temp_output_1_0_g42 - _BaseRotationPosition , float2x2( cos5_g42 , -sin5_g42 , sin5_g42 , cos5_g42 )) + _BaseRotationPosition;
			float2 lerpResult10_g42 = lerp( panner6_g42 , rotator5_g42 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2D( _Texture, lerpResult10_g42 );
			float4 temp_output_315_0 = ( tex2DNode135 * _BaseColor );
			float4 BaseColor66 = temp_output_315_0;
			o.Emission = ( BaseColor66 * float4( (_OutlineTint).rgb , 0.0 ) ).rgb;
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
		GrabPass{ }
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
			float4 screenPos;
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
		uniform int _CompBack;
		uniform int _FailBack;
		uniform int _ZFailBack;
		uniform float _ReadMask;
		uniform int _CullMode;
		uniform int _FailFront;
		uniform int _PassFront;
		uniform int _ZFailFront;
		uniform int _CompFront;
		uniform float _WriteMask;
		uniform float _Reference;
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
		uniform sampler2D _RenderTexture;
		uniform float4 _RenderTexture_ST;
		uniform sampler2D _GrabTexture;
		uniform float _DistortionTiling;
		uniform sampler2D _DitortionNormal;
		uniform float _Distortion;
		uniform sampler2D _Back;
		uniform float2 _BackSpeedXY;
		uniform float _BackDepthScale;
		uniform float2 _BackRotationPosition;
		uniform float _BackScrollRotate;
		uniform float4 _BackColor;
		uniform float _DistortionBlend;
		uniform sampler2D _Mid;
		uniform float2 _MidSpeedXY;
		uniform float _MidDepthScale;
		uniform float2 _MidRotationPosition;
		uniform float _MidScrollRotate;
		uniform float4 _MidColor;
		uniform float _ReflectionBlend;
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


		inline float3 ShadeSH911_g40( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		inline float4 UNITY_SAMPLE_TEXCUBE_LOD7_g40( float3 reflVect )
		{
			return UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
		}


		inline float3 DecodeHDR8_g40( float4 val )
		{
			return DecodeHDR(val,unity_SpecCube0_HDR);
		}


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMin, _TessMax, _TessValue );
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 Outline430 = 0;
			v.vertex.xyz += Outline430;
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
			float temp_output_40_0_g40 = Ndot53;
			float temp_output_19_0_g40 = ase_lightAtten;
			float temp_output_30_0_g40 = ( 1.0 - ( ( 1.0 - temp_output_19_0_g40 ) * _WorldSpaceLightPos0.w ) );
			float lerpResult31_g40 = lerp( ( saturate( ( ( temp_output_40_0_g40 + _BaseCellOffset ) / _BaseCellSharpness ) ) * temp_output_19_0_g40 ) , temp_output_30_0_g40 , _ShadowContribution);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_cast_7 = (1.0).xxx;
			float3 temp_output_74_0_g40 = NewNormal51;
			UnityGI gi48_g40 = gi;
			float3 diffNorm48_g40 = temp_output_74_0_g40;
			gi48_g40 = UnityGI_Base( data, 1, diffNorm48_g40 );
			float3 indirectDiffuse48_g40 = gi48_g40.indirect.diffuse + diffNorm48_g40 * 0.0001;
			float3 lerpResult49_g40 = lerp( temp_cast_7 , indirectDiffuse48_g40 , _IndirectDiffuseContribution);
			float3 normal11_g40 = float3(0,1,0);
			float3 localShadeSH911_g40 = ShadeSH911_g40( normal11_g40 );
			float4 transform3_g40 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult6_g40 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform3_g40 ) );
			float3 reflVect7_g40 = normalizeResult6_g40.xyz;
			float4 localUNITY_SAMPLE_TEXCUBE_LOD7_g40 = UNITY_SAMPLE_TEXCUBE_LOD7_g40( reflVect7_g40 );
			float4 val8_g40 = localUNITY_SAMPLE_TEXCUBE_LOD7_g40;
			float3 localDecodeHDR8_g40 = DecodeHDR8_g40( val8_g40 );
			float3 Lighting436 = saturate( ( ( ( lerpResult31_g40 * ase_lightColor.rgb ) + ( ase_lightColor.a * lerpResult49_g40 * temp_output_30_0_g40 ) ) + ( localShadeSH911_g40 + ( localDecodeHDR8_g40 * 0.02 ) ) ) );
			float2 temp_cast_11 = (saturate( (Ndot53*0.5 + 0.5) )).xx;
			float4 ToonRamp437 = tex2D( _ToonRamp, temp_cast_11 );
			float2 uv_RenderTexture = i.uv_texcoord * _RenderTexture_ST.xy + _RenderTexture_ST.zw;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 temp_cast_13 = (_DistortionTiling).xx;
			float2 uv_TexCoord380 = i.uv_texcoord * temp_cast_13;
			float2 panner382 = ( 1.0 * _Time.y * float2( -0.03,0 ) + uv_TexCoord380);
			float2 panner381 = ( 1.0 * _Time.y * float2( 0.04,0.04 ) + uv_TexCoord380);
			float4 screenColor375 = tex2D( _GrabTexture, ( float3( (ase_grabScreenPosNorm).xy ,  0.0 ) + ( BlendNormals( UnpackNormal( tex2D( _DitortionNormal, panner382 ) ) , UnpackNormal( tex2D( _DitortionNormal, panner381 ) ) ) * _Distortion ) ).xy );
			float2 temp_output_2_0_g43 = _BackSpeedXY;
			float2 Offset121 = ( ( 0.0 - 1 ) * i.viewDir.xy * _BackDepthScale ) + i.uv_texcoord;
			float2 temp_output_1_0_g43 = Offset121;
			float2 panner6_g43 = ( _Time.x * temp_output_2_0_g43 + temp_output_1_0_g43);
			float cos5_g43 = cos( ( _Time.x * (temp_output_2_0_g43).x ) );
			float sin5_g43 = sin( ( _Time.x * (temp_output_2_0_g43).x ) );
			float2 rotator5_g43 = mul( temp_output_1_0_g43 - _BackRotationPosition , float2x2( cos5_g43 , -sin5_g43 , sin5_g43 , cos5_g43 )) + _BackRotationPosition;
			float2 lerpResult10_g43 = lerp( panner6_g43 , rotator5_g43 , _BackScrollRotate);
			float4 lerpResult414 = lerp( screenColor375 , ( tex2D( _Back, lerpResult10_g43 ) * _BackColor ) , _DistortionBlend);
			float2 temp_output_2_0_g44 = _MidSpeedXY;
			float2 Offset122 = ( ( 0.0 - 1 ) * i.viewDir.xy * _MidDepthScale ) + i.uv_texcoord;
			float2 temp_output_1_0_g44 = Offset122;
			float2 panner6_g44 = ( _Time.x * temp_output_2_0_g44 + temp_output_1_0_g44);
			float cos5_g44 = cos( ( _Time.x * (temp_output_2_0_g44).x ) );
			float sin5_g44 = sin( ( _Time.x * (temp_output_2_0_g44).x ) );
			float2 rotator5_g44 = mul( temp_output_1_0_g44 - _MidRotationPosition , float2x2( cos5_g44 , -sin5_g44 , sin5_g44 , cos5_g44 )) + _MidRotationPosition;
			float2 lerpResult10_g44 = lerp( panner6_g44 , rotator5_g44 , _MidScrollRotate);
			float4 tex2DNode128 = tex2D( _Mid, lerpResult10_g44 );
			float4 lerpResult142 = lerp( lerpResult414 , ( tex2DNode128 * _MidColor ) , tex2DNode128.a);
			float4 lerpResult422 = lerp( tex2D( _RenderTexture, uv_RenderTexture ) , lerpResult142 , _ReflectionBlend);
			float2 temp_output_2_0_g42 = _BaseSpeedXY;
			float2 temp_output_1_0_g42 = i.uv_texcoord;
			float2 panner6_g42 = ( _Time.x * temp_output_2_0_g42 + temp_output_1_0_g42);
			float cos5_g42 = cos( ( _Time.x * (temp_output_2_0_g42).x ) );
			float sin5_g42 = sin( ( _Time.x * (temp_output_2_0_g42).x ) );
			float2 rotator5_g42 = mul( temp_output_1_0_g42 - _BaseRotationPosition , float2x2( cos5_g42 , -sin5_g42 , sin5_g42 , cos5_g42 )) + _BaseRotationPosition;
			float2 lerpResult10_g42 = lerp( panner6_g42 , rotator5_g42 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2D( _Texture, lerpResult10_g42 );
			float4 temp_output_315_0 = ( tex2DNode135 * _BaseColor );
			float4 lerpResult143 = lerp( lerpResult422 , temp_output_315_0 , tex2D( _Mask, i.uv_texcoord ).r);
			float4 Parallax427 = lerpResult143;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult29 = dot( NewNormal51 , ase_worldViewDir );
			#ifdef _USERIM_ON
				float3 staticSwitch202 = ( ( saturate( Ndot53 ) * pow( ( 1.0 - saturate( ( dotResult29 + _RimOffset ) ) ) , _RimPower ) ) * (_RimColor).rgb );
			#else
				float3 staticSwitch202 = float3( 0,0,0 );
			#endif
			float3 RimLight431 = staticSwitch202;
			float2 uv_SpecularMap97 = i.uv_texcoord;
			float4 temp_output_23_0_g40 = ( tex2D( _SpecularMap, uv_SpecularMap97 ) * _Specular );
			float temp_output_64_0_g40 = (temp_output_23_0_g40).w;
			float3 temp_cast_17 = (1.0).xxx;
			float3 indirectNormal20_g40 = temp_output_74_0_g40;
			float2 uv_OcculusionMap333 = i.uv_texcoord;
			Unity_GlossyEnvironmentData g20_g40 = UnityGlossyEnvironmentSetup( temp_output_64_0_g40, data.worldViewDir, indirectNormal20_g40, float3(0,0,0));
			float3 indirectSpecular20_g40 = UnityGI_IndirectSpecular( data, ( tex2D( _OcculusionMap, uv_OcculusionMap333 ) * _OcculusionStrength ).r, indirectNormal20_g40, g20_g40 );
			float3 lerpResult67_g40 = lerp( temp_cast_17 , indirectSpecular20_g40 , _IndirectSpecularContribution);
			float3 SpecSmooth435 = ( saturate( ( ( temp_output_40_0_g40 + _HighlightCellOffset ) / ( _HighlightCellSharpness * ( 1.0 - temp_output_64_0_g40 ) ) ) ) * (temp_output_23_0_g40).xyz * pow( temp_output_64_0_g40 , 1.5 ) * lerpResult67_g40 );
			c.rgb = saturate( ( ( float4( Lighting436 , 0.0 ) * ToonRamp437 * Parallax427 ) + float4( RimLight431 , 0.0 ) + float4( SpecSmooth435 , 0.0 ) ) ).rgb;
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
			float2 temp_output_2_0_g42 = _BaseSpeedXY;
			float2 temp_output_1_0_g42 = i.uv_texcoord;
			float2 panner6_g42 = ( _Time.x * temp_output_2_0_g42 + temp_output_1_0_g42);
			float cos5_g42 = cos( ( _Time.x * (temp_output_2_0_g42).x ) );
			float sin5_g42 = sin( ( _Time.x * (temp_output_2_0_g42).x ) );
			float2 rotator5_g42 = mul( temp_output_1_0_g42 - _BaseRotationPosition , float2x2( cos5_g42 , -sin5_g42 , sin5_g42 , cos5_g42 )) + _BaseRotationPosition;
			float2 lerpResult10_g42 = lerp( panner6_g42 , rotator5_g42 , _BaseScrollRotate);
			float4 tex2DNode135 = tex2D( _Texture, lerpResult10_g42 );
			float4 temp_output_315_0 = ( tex2DNode135 * _BaseColor );
			float4 BaseColor66 = temp_output_315_0;
			o.Albedo = BaseColor66.rgb;
			float2 uv_EmisionMask59 = i.uv_texcoord;
			float4 temp_output_2_0_g41 = tex2D( _EmisionMask, uv_EmisionMask59 );
			float4 lerpResult33_g41 = lerp( BaseColor66 , ( _EmissionColor * _EmissionIntensity ) , temp_output_2_0_g41);
			float4 Emissive429 = ( lerpResult33_g41 * temp_output_2_0_g41 );
			o.Emission = Emissive429.rgb;
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
				float4 screenPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.screenPos = IN.screenPos;
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
1927;29;1906;1004;-111.3838;-221.0445;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;428;-3843.544,-1998.81;Float;False;4219.118;2167.634;Comment;5;370;144;415;414;417;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;43;-950.9378,315.4031;Float;False;1370.182;280;Comment;5;51;48;46;45;44;Normals;0.5220588,0.6044625,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;370;-3712.692,-1948.81;Float;False;2099.11;524.8445;Get screen color for refraction and disturbe it with normals;13;382;381;380;389;390;391;375;374;373;372;371;378;416;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-900.9385,391.9127;Float;False;Property;_NormalScale;Normal Scale;25;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;416;-3704.168,-1827.042;Float;False;Property;_DistortionTiling;Distortion Tiling;50;0;Create;True;0;0;False;0;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-569.3322,364.4032;Float;True;Property;_Normal;Normal;24;2;[Normal];[NoScaleOffset];Create;True;0;0;False;1;Header(Normal) ;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;380;-3617.346,-1731.412;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;10,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;144;-3793.545,-1384.23;Float;False;4131.704;1523.125;Comment;40;425;314;142;312;118;315;143;121;76;271;422;116;117;215;231;218;128;264;137;122;134;211;135;115;66;120;404;266;260;311;223;427;301;309;307;303;308;313;136;299;Parallax Mapping;0.6617647,1,0.734077,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;46;-250.549,370.6433;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;382;-3362.646,-1758.71;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;115;-3743.545,-1051.458;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;381;-3360.345,-1646.211;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalizeNode;48;-8.914479,369.6997;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;389;-3125.905,-1626.395;Float;True;Property;_DitortionNormal;Ditortion Normal;48;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;None;24e31ecbf813d9e49bf7a1e0d4034916;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;390;-3127.331,-1836.847;Float;True;Property;_TextureSample0;Texture Sample 0;48;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Instance;389;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;120;-3396.875,-1186.092;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;116;-3366.533,-1286.031;Float;False;Property;_BackDepthScale;Back Depth Scale;15;0;Create;True;0;0;False;0;0;0.044;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;404;-3454.588,-1284.41;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;176.2413,371.1507;Float;False;NewNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;25;-1912.256,619.5065;Float;False;2346.008;510.9342;Comment;17;39;28;26;38;42;35;34;36;32;37;33;30;27;29;31;202;431;Rim Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-3362.019,-986.5595;Float;False;Property;_MidDepthScale;Mid Depth Scale;9;0;Create;True;0;0;False;0;0;0.009;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;271;-2305.505,-1112.999;Float;False;Property;_BackRotationPosition;Back Rotation Position;18;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;266;-2683.957,-1120.841;Float;False;Property;_BackScrollRotate;Back Scroll/Rotate;16;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;391;-2787.025,-1719.958;Float;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;211;-2940.857,-1183.77;Float;False;Property;_BackSpeedXY;Back Speed(X/Y);17;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ParallaxMappingNode;121;-2961.458,-1339.971;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GrabScreenPosition;371;-2555.076,-1889.45;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;378;-2458.291,-1631.406;Float;False;Property;_Distortion;Distortion;47;0;Create;True;0;0;False;1;Header(Distortion);0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;26;-1815.225,831.2845;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1862.256,720.0756;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;118;-3184.186,-1044.675;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;47;-1897.886,249.1528;Float;False;835.6508;341.2334;Comment;4;53;52;50;49;N dot L;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;223;-2321.287,-696.0367;Float;False;Property;_MidRotationPosition;Mid Rotation Position;12;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;218;-2930.986,-864.529;Float;False;Property;_MidSpeedXY;Mid Speed(X/Y);11;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;231;-2577.002,-765.3082;Float;False;Property;_MidScrollRotate;Mid Scroll/Rotate;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;307;-1980.427,-1333.071;Float;False;UVMove;-1;;43;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;122;-2961.982,-1024.566;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;-2203.182,-1727.81;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;372;-2251.729,-1832.316;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;49;-1853.738,434.789;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;29;-1510.123,766.3926;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1820.828,299.153;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1567.522,883.6096;Float;False;Property;_RimOffset;Rim Offset;22;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;374;-2029.084,-1796.708;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;134;-1701.858,-1328.607;Float;True;Property;_Back;Back;13;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;312;-1641.432,-1125.422;Float;False;Property;_BackColor;Back Color;14;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.2,1.2,1.2,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;308;-1997.123,-868.1533;Float;False;UVMove;-1;;44;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1286.524,770.6096;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;52;-1523.595,335.9519;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;264;-2752.944,-237.7679;Float;False;Property;_BaseScrollRotate;Base Scroll/Rotate;4;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;313;-1492.838,-692.1539;Float;False;Property;_MidColor;Mid Color;8;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.2,1.2,1.2,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;375;-1815.982,-1795.31;Float;False;Global;_GrabScreen0;Grab Screen 0;-1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;415;-1449.251,-1485.085;Float;False;Property;_DistortionBlend;Distortion Blend;49;0;Create;True;0;0;False;0;1;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-1389.58,-1236.995;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;128;-1576.089,-893.3998;Float;True;Property;_Mid;Mid;7;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Parallax Mapping) ;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;318;-3252.265,1473.699;Float;False;1143.029;327.8645;Comment;6;317;320;321;437;319;322;Toon Ramp;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;215;-2969.988,-352.6284;Float;False;Property;_BaseSpeedXY;Base Speed(X/Y);5;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;260;-2401.076,-202.9222;Float;False;Property;_BaseRotationPosition;Base Rotation Position;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;31;-1126.524,770.6096;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-1305.236,339.2675;Float;False;Ndot;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;301;-3036.808,-634.7714;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;414;-1085.402,-1564.876;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;317;-3233.264,1690.699;Float;False;Constant;_WrapperValue;Wrapper Value;32;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-1180.309,-969.4926;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;319;-3224.264,1560.699;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;299;-3163.827,-283.2691;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;57;-3252.559,258.5832;Float;False;1193.978;973.8955;Comment;12;97;290;335;333;334;14;98;432;433;434;435;436;Custom Toon;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-995.1564,669.5066;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1062.524,898.6096;Float;False;Property;_RimPower;Rim Power;21;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;32;-950.5246,770.6096;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;309;-2083.047,-383.9349;Float;False;UVMove;-1;;42;b9a7d6c5a9a2543498ef7500c85b9f70;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;334;-3210.67,1148.961;Float;False;Property;_OcculusionStrength;Occulusion Strength;34;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-3203.484,866.8743;Float;False;Property;_Specular;Specular;32;0;Create;True;0;0;False;0;0;0.119;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-3224.484,676.8746;Float;True;Property;_SpecularMap;Specular Map;31;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Specular) ;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;425;-872.7028,-972.1105;Float;False;Property;_ReflectionBlend;Reflection Blend;52;0;Create;True;0;0;False;0;1;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;303;-1613.851,-61.1755;Float;True;Property;_Mask;Mask;19;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;320;-3026.264,1546.699;Float;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;142;-862.436,-1136.577;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;417;-1158.816,-1773.086;Float;True;Property;_RenderTexture;Render Texture;51;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-749.132,930.7135;Float;False;Property;_RimColor;Rim Color;20;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0.377;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;37;-758.5241,770.6096;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;35;-769.301,691.3666;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;314;-1552.663,-262.3897;Float;False;Property;_BaseColor;Base Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;135;-1622.185,-481.2145;Float;True;Property;_Texture;Texture;1;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Texture);None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;333;-3221.655,954.0481;Float;True;Property;_OcculusionMap;Occulusion Map;33;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Occulusion);None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;67;-856.0303,1234.5;Float;False;1308.617;434.9737;Comment;9;75;73;74;72;71;70;69;68;430;Alpha Outline;1,0.6029412,0.7097364,1;0;0
Node;AmplifyShaderEditor.LerpOp;422;-559.6832,-1201.195;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;311;-685.8568,-662.048;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;335;-2892.764,953.5398;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;321;-2788.264,1548.699;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;14;-3138.484,606.8746;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;434;-3104.232,443.4781;Float;False;53;Ndot;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;432;-2888.563,703.4781;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-474.3959,699.3835;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;433;-3122.232,526.4781;Float;False;51;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;315;-1244.272,-476.3022;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;38;-465.2999,938.7914;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;143;-258.9746,-1068.823;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;-1029.977,-258.1905;Float;False;OutlineCustomWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;322;-2613.265,1569.699;Float;True;Property;_ToonRamp;Toon Ramp;2;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-730.7237,-470.3238;Float;False;BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-188.4419,692.4355;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;68;-795.5175,1376.542;Float;False;Property;_OutlineTint;Outline Tint;29;0;Create;True;0;0;False;1;Header(Outline) ;0.5294118,0.5294118,0.5294118,0;0.5294118,0.5294118,0.5294118,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;290;-2688.782,567.2901;Float;True;CustomToon;53;;40;3d617e4dd05588d4eaea2c27e10e95bb;0;5;40;FLOAT;0;False;74;FLOAT3;0,0,0;False;19;FLOAT;0;False;23;FLOAT4;0,0,0,0;False;24;FLOAT;1;False;2;FLOAT3;72;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;-504.2712,1579.485;Float;False;76;OutlineCustomWidth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-523.3303,1477.767;Float;False;Property;_OutlineWidth;Outline Width;30;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;436;-2320.778,635.2745;Float;False;Lighting;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;427;57.11295,-1094.246;Float;False;Parallax;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;69;-491.8372,1378.783;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;446;664.5055,341.7487;Float;False;687.6399;569.765;Comment;9;438;441;442;439;440;443;444;445;458;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-542.7573,1288.742;Float;False;66;BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;202;39.35903,691.7525;Float;False;Property;_UseRim;Use Rim;23;0;Create;True;0;0;False;1;Toggle;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;437;-2327.445,1573.058;Float;False;ToonRamp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;58;-1991.881,1220.398;Float;False;869.3591;786.913;Comment;6;62;60;63;429;59;209;Emissive Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-1964.254,1269.562;Float;True;66;BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-231.9834,1330.783;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0.3382353,0.3382353,0.3382353;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;732.3062,554.5679;Float;False;427;Parallax;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;727.7198,391.7487;Float;False;436;Lighting;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;439;714.5055,469.5358;Float;False;437;ToonRamp;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;-1981.601,1488.82;Float;True;Property;_EmisionMask;Emision Mask;28;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;435;-2319.778,525.2745;Float;False;SpecSmooth;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1971.272,1880.364;Float;False;Property;_EmissionIntensity;Emission Intensity;27;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;431;235.8459,691.386;Float;False;RimLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;63;-1952.643,1695.58;Float;False;Property;_EmissionColor;Emission Color;26;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-180.9496,1482.836;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;368;-438.5235,1827.181;Float;False;861.6099;784.1021;Comment;2;367;355;Master Node Output Options;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;444;951.245,484.0314;Float;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;209;-1616.733,1522.265;Float;True;EmissiveMask;-1;;41;8475a84330edb2b41933a47e12b3e1d8;0;4;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;734.4205,722.9836;Float;False;431;RimLight;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;443;717.7635,796.5137;Float;False;435;SpecSmooth;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OutlineNode;75;-66.41846,1332.561;Float;False;0;True;None;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;429;-1339.666,1514.248;Float;False;Emissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;445;1087.145,565.2314;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;355;-73.32239,1912.072;Float;False;408.8691;641.6335;Comment;11;366;365;364;363;362;361;360;359;358;357;356;Stencil Buffer;0.0147059,1,0.9184586,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;367;-346.4305,1907.066;Float;False;232;165;Comment;1;340;Cull Mode;0.1172414,1,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;430;185.2266,1328.064;Float;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;449;-2366.9,2073.797;Float;False;1297.319;395.4562;Comment;8;457;456;455;454;453;452;451;450;Matcap;0.6965518,1,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1419.039,260.2243;Float;False;66;BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;457;-1283.931,2215.134;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;365;-54.08756,2432.283;Float;False;Property;_ZFailFront;ZFail Front;42;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;366;-54.08756,2112.284;Float;False;Property;_WriteMask;Write Mask;37;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;448;1474.045,628.3314;Float;False;430;Outline;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;360;-54.08756,1952.284;Float;False;Property;_Reference;Reference;35;1;[IntRange];Create;True;0;0;True;0;0;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;456;-1601.781,2213.653;Float;True;Property;_Matcap;Matcap;41;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;458;1215.124,572.5375;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;440;730.6915,659.1088;Float;False;457;Matcap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;359;-54.08756,2272.283;Float;False;Property;_PassFront;Pass Front;39;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;452;-2108.568,2155.183;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;453;-2119.385,2283.558;Float;False;Constant;_Float3;Float 3;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;451;-2347.299,2219.531;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IntNode;364;153.9122,2272.283;Float;False;Property;_PassBack;Pass Back;44;1;[Enum];Create;True;0;1;UnityEngine.Rendering.StencilOp;True;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;361;153.9122,2192.283;Float;False;Property;_CompBack;Comp. Back;43;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;455;-1766.007,2241.706;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;363;153.9122,2432.283;Float;False;Property;_ZFailBack;ZFail Back;46;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;362;153.9122,2352.283;Float;False;Property;_FailBack;Fail Back;45;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;447;1425.945,343.6314;Float;False;429;Emissive;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;357;-54.08756,2192.283;Float;False;Property;_CompFront;Comp. Front;38;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;8;8;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;358;-54.08756,2352.283;Float;False;Property;_FailFront;Fail Front;40;1;[Enum];Create;True;1;Option1;0;1;UnityEngine.Rendering.StencilOp;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.ViewMatrixNode;450;-2267.111,2125.397;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;356;-54.08756,2032.284;Float;False;Property;_ReadMask;Read Mask;36;1;[IntRange];Create;True;0;0;True;0;255;0;0;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;340;-303.8775,1968.242;Float;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;True;3;Back;0;Front;1;Off;2;1;UnityEngine.Rendering.CullMode;True;0;0;2;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;454;-1941.316,2191.629;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1684.826,291.4542;Float;False;True;6;Float;IsuzuShader.Editor.CharacterShaderCustomInspector;0;0;CustomLighting;ASE/Character/CharacterToon_Parallax_DistReflex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;1;True;352;0;True;348;True;0;True;350;0;True;351;False;0;Translucent;0.5;True;True;0;False;Opaque;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;True;0;True;360;255;True;356;255;True;366;0;True;357;0;True;359;0;True;358;0;True;365;0;True;361;0;True;364;0;True;362;0;True;363;True;0;4;10;25;False;0.5;True;0;5;True;354;10;True;347;2;5;True;345;10;True;346;0;True;349;1;True;343;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;61;0;False;0;0;True;340;-1;0;True;353;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;5;44;0
WireConnection;380;0;416;0
WireConnection;46;0;45;0
WireConnection;382;0;380;0
WireConnection;381;0;380;0
WireConnection;48;0;46;0
WireConnection;389;1;381;0
WireConnection;390;1;382;0
WireConnection;404;0;115;0
WireConnection;51;0;48;0
WireConnection;391;0;390;0
WireConnection;391;1;389;0
WireConnection;121;0;404;0
WireConnection;121;2;116;0
WireConnection;121;3;120;0
WireConnection;118;0;115;0
WireConnection;307;1;121;0
WireConnection;307;2;211;0
WireConnection;307;3;266;0
WireConnection;307;4;271;0
WireConnection;122;0;118;0
WireConnection;122;2;117;0
WireConnection;122;3;120;0
WireConnection;373;0;391;0
WireConnection;373;1;378;0
WireConnection;372;0;371;0
WireConnection;29;0;27;0
WireConnection;29;1;26;0
WireConnection;374;0;372;0
WireConnection;374;1;373;0
WireConnection;134;1;307;0
WireConnection;308;1;122;0
WireConnection;308;2;218;0
WireConnection;308;3;231;0
WireConnection;308;4;223;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;52;0;50;0
WireConnection;52;1;49;0
WireConnection;375;0;374;0
WireConnection;137;0;134;0
WireConnection;137;1;312;0
WireConnection;128;1;308;0
WireConnection;31;0;30;0
WireConnection;53;0;52;0
WireConnection;301;0;115;0
WireConnection;414;0;375;0
WireConnection;414;1;137;0
WireConnection;414;2;415;0
WireConnection;136;0;128;0
WireConnection;136;1;313;0
WireConnection;299;0;115;0
WireConnection;32;0;31;0
WireConnection;309;1;301;0
WireConnection;309;2;215;0
WireConnection;309;3;264;0
WireConnection;309;4;260;0
WireConnection;303;1;299;0
WireConnection;320;0;319;0
WireConnection;320;1;317;0
WireConnection;320;2;317;0
WireConnection;142;0;414;0
WireConnection;142;1;136;0
WireConnection;142;2;128;4
WireConnection;37;0;32;0
WireConnection;37;1;33;0
WireConnection;35;0;34;0
WireConnection;135;1;309;0
WireConnection;422;0;417;0
WireConnection;422;1;142;0
WireConnection;422;2;425;0
WireConnection;311;0;303;1
WireConnection;335;0;333;0
WireConnection;335;1;334;0
WireConnection;321;0;320;0
WireConnection;432;0;97;0
WireConnection;432;1;98;0
WireConnection;39;0;35;0
WireConnection;39;1;37;0
WireConnection;315;0;135;0
WireConnection;315;1;314;0
WireConnection;38;0;36;0
WireConnection;143;0;422;0
WireConnection;143;1;315;0
WireConnection;143;2;311;0
WireConnection;76;0;135;4
WireConnection;322;1;321;0
WireConnection;66;0;315;0
WireConnection;42;0;39;0
WireConnection;42;1;38;0
WireConnection;290;40;434;0
WireConnection;290;74;433;0
WireConnection;290;19;14;0
WireConnection;290;23;432;0
WireConnection;290;24;335;0
WireConnection;436;0;290;0
WireConnection;427;0;143;0
WireConnection;69;0;68;0
WireConnection;202;0;42;0
WireConnection;437;0;322;0
WireConnection;73;0;71;0
WireConnection;73;1;69;0
WireConnection;435;0;290;72
WireConnection;431;0;202;0
WireConnection;74;0;72;0
WireConnection;74;1;70;0
WireConnection;444;0;438;0
WireConnection;444;1;439;0
WireConnection;444;2;441;0
WireConnection;209;1;60;0
WireConnection;209;2;59;0
WireConnection;209;3;63;0
WireConnection;209;4;62;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;429;0;209;0
WireConnection;445;0;444;0
WireConnection;445;1;442;0
WireConnection;445;2;443;0
WireConnection;430;0;75;0
WireConnection;457;0;456;0
WireConnection;456;1;455;0
WireConnection;458;0;445;0
WireConnection;452;0;450;0
WireConnection;452;1;451;0
WireConnection;455;0;454;0
WireConnection;455;1;453;0
WireConnection;454;0;452;0
WireConnection;454;1;453;0
WireConnection;0;0;197;0
WireConnection;0;2;447;0
WireConnection;0;13;458;0
WireConnection;0;11;448;0
ASEEND*/
//CHKSM=5FA28716C8A78A8A642854B4DF329FDC8B4D60A9