// Copyright © 2019 shiranui_isuzu. All rights reserved.
// https://twitter.com/Shiranui_Isuzu_

using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using NUnit.Framework;
using UnityEditor;
using UnityEngine;

///<inheritdoc />
/// このクラスはShaderPropertyGeneratorにより
/// 2019/02/19 06:59:17に自動生成されました。
/// このファイルをエディタで直接編集しないでください。
/// </summary>
public class CharacterShaderCustomInspector : ShaderGUI
{
    #region Fields
    private string texture                    = "_Texture"; 
    private string toonRamp                   = "_ToonRamp"; 
    private string baseColor                  = "_BaseColor"; 
    private string baseScrollRotate           = "_BaseScrollRotate"; 
    private string baseSpeedXY                = "_BaseSpeedXY"; 
    private string baseRotationPosition       = "_BaseRotationPosition"; 
    private string baseCellOffset             = "_BaseCellOffset"; 
    private string baseCellSharpness          = "_BaseCellSharpness"; 
    private string indirectDiffuseContribution= "_IndirectDiffuseContribution"; 
    private string highlightCellOffset        = "_HighlightCellOffset"; 
    private string highlightCellSharpness     = "_HighlightCellSharpness"; 
    private string shadowContribution         = "_ShadowContribution"; 
    private string matcap                     = "_Matcap"; 
    private string mid                        = "_Mid"; 
    private string midColor                   = "_MidColor"; 
    private string midDepthScale              = "_MidDepthScale"; 
    private string midScrollRotate            = "_MidScrollRotate"; 
    private string midSpeedXY                 = "_MidSpeedXY"; 
    private string midRotationPosition        = "_MidRotationPosition"; 
    private string back                       = "_Back"; 
    private string backColor                  = "_BackColor"; 
    private string backDepthScale             = "_BackDepthScale"; 
    private string backScrollRotate           = "_BackScrollRotate"; 
    private string backSpeedXY                = "_BackSpeedXY"; 
    private string backRotationPosition       = "_BackRotationPosition"; 
    private string mask                       = "_Mask"; 
    private string rimColor                   = "_RimColor"; 
    private string rimPower                   = "_RimPower"; 
    private string rimOffset                  = "_RimOffset"; 
    private string useRim                     = "_UseRim"; 
    private string normal                     = "_Normal"; 
    private string normalScale                = "_NormalScale"; 
    private string emissionColor              = "_EmissionColor"; 
    private string emissionIntensity          = "_EmissionIntensity"; 
    private string emisionMask                = "_EmisionMask"; 
    private string specularMap                = "_SpecularMap"; 
    private string specularTint               = "_SpecularTint"; 
    private string anisotropyX                = "_AnisotropyX"; 
    private string anisotropyY                = "_AnisotropyY"; 
    private string anisotropyX2               = "_AnisotropyX2"; 
    private string anisotropyY2               = "_AnisotropyY2"; 
    private string layer2BlendWeight          = "_Layer2BlendWeight"; 
    private string useAnisotropic             = "_UseAnisotropic"; 
    private string occulusionMap              = "_OcculusionMap"; 
    private string occulusionStrength         = "_OcculusionStrength"; 
    private string sSSType                    = "_SSSType"; 
    private string sSSMap                     = "_SSSMap"; 
    private string sSSMultiplier              = "_SSSMultiplier"; 
    private string sSSColor                   = "_SSSColor"; 
    private string sSSColorPower              = "_SSSColorPower"; 
    private string sSSScale                   = "_SSSScale"; 
    private string sSSPower                   = "_SSSPower"; 
    private string shadowStrength             = "_ShadowStrength"; 
    private string pointLightPunchthrough     = "_PointLightPunchthrough"; 
    private string subsurfaceDistortion       = "_SubsurfaceDistortion"; 
    private string useSSS                     = "_UseSSS"; 
    private string maskClipValue              = "_MaskClipValue"; 
    private string opacity                    = "_Opacity"; 
    private string outlineTint                = "_OutlineTint"; 
    private string outlineWidth               = "_OutlineWidth"; 
    private string tessValue                  = "_TessValue"; 
    private string tessMin                    = "_TessMin"; 
    private string tessMax                    = "_TessMax"; 
    private string tessPhongStrength          = "_TessPhongStrength"; 
    private string renderTexture              = "_RenderTexture"; 
    private string reflectionBlend            = "_ReflectionBlend"; 
    private string reference                  = "_Reference"; 
    private string readMask                   = "_ReadMask"; 
    private string writeMask                  = "_WriteMask"; 
    private string compFront                  = "_CompFront"; 
    private string passFront                  = "_PassFront"; 
    private string failFront                  = "_FailFront"; 
    private string zFailFront                 = "_ZFailFront"; 
    private string compBack                   = "_CompBack"; 
    private string passBack                   = "_PassBack"; 
    private string failBack                   = "_FailBack"; 
    private string zFailBack                  = "_ZFailBack"; 
    private string blendRGBSrc                = "_BlendRGBSrc"; 
    private string blendRGBDst                = "_BlendRGBDst"; 
    private string blendOpRGB                 = "_BlendOpRGB"; 
    private string blendAlphaSrc              = "_BlendAlphaSrc"; 
    private string blendAlphaDst              = "_BlendAlphaDst"; 
    private string blendOpAlpha               = "_BlendOpAlpha"; 
    private string cullMode                   = "_CullMode"; 
    private string useLightColor              = "_UseLightColor"; 
    private string staticHighLights           = "_StaticHighLights"; 
    private bool textureFold = false;
    private bool matcapFold = false;
    private bool midFold = false;
    private bool rimColorFold = false;
    private bool normalFold = false;
    private bool emissionColorFold = false;
    private bool specularMapFold = false;
    private bool anisotropyXFold = false;
    private bool occulusionMapFold = false;
    private bool sSSTypeFold = false;
    private bool maskClipValueFold = false;
    private bool outlineTintFold = false;
    private bool renderTextureFold = false;
    private bool referenceFold = false;
    private bool blendRGBSrcFold = false;
    private bool cullModeFold = false;
    private bool useRimToggle = true;
    private bool useAnisotropicToggle = true;
    private bool useSSSToggle = true;

    private bool renderingFold        = false;
    private bool firstInspectedEditor = true;
    #endregion

    public CharacterShaderCustomInspector()
    {
    }

    ///<inheritdoc />
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        Undo.undoRedoPerformed += () => { materialEditor.Repaint(); };

        var material = materialEditor.target as Material;

        if (material == null) return;

        if (materialEditor.isVisible)
        {
            using (new GUILayout.HorizontalScope())
            {
                if (GUILayout.Button("Copy Values"))
                {
                    SaveMaterialProperties(material);
                }

                if (GUILayout.Button("Past Values"))
                {
                    LoadMaterialProperties(material);
                    materialEditor.PropertiesChanged();
                }
            }

            using (new GUILayout.HorizontalScope())
            {
                if (GUILayout.Button("Export Template"))
                {
                    SaveTemplateData(material);
                }

                if (GUILayout.Button("Import Template"))
                {
                    LoadTemplateData(material);
                    materialEditor.PropertiesChanged();
                }
            }

            GUILayout.Space(5);
        }

        var textureProp                     = FindProperty(this.texture, properties);
        var toonRampProp                    = FindProperty(this.toonRamp, properties);
        var baseColorProp                   = FindProperty(this.baseColor, properties);
        var baseScrollRotateProp            = FindProperty(this.baseScrollRotate, properties);
        var baseSpeedXYProp                 = FindProperty(this.baseSpeedXY, properties);
        var baseRotationPositionProp        = FindProperty(this.baseRotationPosition, properties);
        var baseCellOffsetProp              = FindProperty(this.baseCellOffset, properties);
        var baseCellSharpnessProp           = FindProperty(this.baseCellSharpness, properties);
        var indirectDiffuseContributionProp = FindProperty(this.indirectDiffuseContribution, properties);
        var highlightCellOffsetProp         = FindProperty(this.highlightCellOffset, properties);
        var highlightCellSharpnessProp      = FindProperty(this.highlightCellSharpness, properties);
        var shadowContributionProp          = FindProperty(this.shadowContribution, properties);
        var matcapProp                      = FindProperty(this.matcap, properties);
        var midProp                         = FindProperty(this.mid, properties);
        var midColorProp                    = FindProperty(this.midColor, properties);
        var midDepthScaleProp               = FindProperty(this.midDepthScale, properties);
        var midScrollRotateProp             = FindProperty(this.midScrollRotate, properties);
        var midSpeedXYProp                  = FindProperty(this.midSpeedXY, properties);
        var midRotationPositionProp         = FindProperty(this.midRotationPosition, properties);
        var backProp                        = FindProperty(this.back, properties);
        var backColorProp                   = FindProperty(this.backColor, properties);
        var backDepthScaleProp              = FindProperty(this.backDepthScale, properties);
        var backScrollRotateProp            = FindProperty(this.backScrollRotate, properties);
        var backSpeedXYProp                 = FindProperty(this.backSpeedXY, properties);
        var backRotationPositionProp        = FindProperty(this.backRotationPosition, properties);
        var maskProp                        = FindProperty(this.mask, properties);
        var rimColorProp                    = FindProperty(this.rimColor, properties);
        var rimPowerProp                    = FindProperty(this.rimPower, properties);
        var rimOffsetProp                   = FindProperty(this.rimOffset, properties);
        var useRimProp                      = FindProperty(this.useRim, properties);
        var normalProp                      = FindProperty(this.normal, properties);
        var normalScaleProp                 = FindProperty(this.normalScale, properties);
        var emissionColorProp               = FindProperty(this.emissionColor, properties);
        var emissionIntensityProp           = FindProperty(this.emissionIntensity, properties);
        var emisionMaskProp                 = FindProperty(this.emisionMask, properties);
        var specularMapProp                 = FindProperty(this.specularMap, properties);
        var specularTintProp                = FindProperty(this.specularTint, properties);
        var anisotropyXProp                 = FindProperty(this.anisotropyX, properties);
        var anisotropyYProp                 = FindProperty(this.anisotropyY, properties);
        var anisotropyX2Prop                = FindProperty(this.anisotropyX2, properties);
        var anisotropyY2Prop                = FindProperty(this.anisotropyY2, properties);
        var layer2BlendWeightProp           = FindProperty(this.layer2BlendWeight, properties);
        var useAnisotropicProp              = FindProperty(this.useAnisotropic, properties);
        var occulusionMapProp               = FindProperty(this.occulusionMap, properties);
        var occulusionStrengthProp          = FindProperty(this.occulusionStrength, properties);
        var sSSTypeProp                     = FindProperty(this.sSSType, properties);
        var sSSMapProp                      = FindProperty(this.sSSMap, properties);
        var sSSMultiplierProp               = FindProperty(this.sSSMultiplier, properties);
        var sSSColorProp                    = FindProperty(this.sSSColor, properties);
        var sSSColorPowerProp               = FindProperty(this.sSSColorPower, properties);
        var sSSScaleProp                    = FindProperty(this.sSSScale, properties);
        var sSSPowerProp                    = FindProperty(this.sSSPower, properties);
        var shadowStrengthProp              = FindProperty(this.shadowStrength, properties);
        var pointLightPunchthroughProp      = FindProperty(this.pointLightPunchthrough, properties);
        var subsurfaceDistortionProp        = FindProperty(this.subsurfaceDistortion, properties);
        var useSSSProp                      = FindProperty(this.useSSS, properties);
        var maskClipValueProp               = FindProperty(this.maskClipValue, properties);
        var opacityProp                     = FindProperty(this.opacity, properties);
        var outlineTintProp                 = FindProperty(this.outlineTint, properties);
        var outlineWidthProp                = FindProperty(this.outlineWidth, properties);
        var tessValueProp                   = FindProperty(this.tessValue, properties);
        var tessMinProp                     = FindProperty(this.tessMin, properties);
        var tessMaxProp                     = FindProperty(this.tessMax, properties);
        var tessPhongStrengthProp           = FindProperty(this.tessPhongStrength, properties);
        var renderTextureProp               = FindProperty(this.renderTexture, properties);
        var reflectionBlendProp             = FindProperty(this.reflectionBlend, properties);
        var referenceProp                   = FindProperty(this.reference, properties);
        var readMaskProp                    = FindProperty(this.readMask, properties);
        var writeMaskProp                   = FindProperty(this.writeMask, properties);
        var compFrontProp                   = FindProperty(this.compFront, properties);
        var passFrontProp                   = FindProperty(this.passFront, properties);
        var failFrontProp                   = FindProperty(this.failFront, properties);
        var zFailFrontProp                  = FindProperty(this.zFailFront, properties);
        var compBackProp                    = FindProperty(this.compBack, properties);
        var passBackProp                    = FindProperty(this.passBack, properties);
        var failBackProp                    = FindProperty(this.failBack, properties);
        var zFailBackProp                   = FindProperty(this.zFailBack, properties);
        var blendRGBSrcProp                 = FindProperty(this.blendRGBSrc, properties);
        var blendRGBDstProp                 = FindProperty(this.blendRGBDst, properties);
        var blendOpRGBProp                  = FindProperty(this.blendOpRGB, properties);
        var blendAlphaSrcProp               = FindProperty(this.blendAlphaSrc, properties);
        var blendAlphaDstProp               = FindProperty(this.blendAlphaDst, properties);
        var blendOpAlphaProp                = FindProperty(this.blendOpAlpha, properties);
        var cullModeProp                    = FindProperty(this.cullMode, properties);
        var useLightColorProp               = FindProperty(this.useLightColor, properties);
        var staticHighLightsProp            = FindProperty(this.staticHighLights, properties);

        using(var scope = new EditorGUI.ChangeCheckScope())
        {
            if(this.firstInspectedEditor)
            {
                this.useRimToggle = useRimProp.floatValue > 0;
                this.useAnisotropicToggle = useAnisotropicProp.floatValue > 0;
                this.useSSSToggle = useSSSProp.floatValue > 0;
                this.firstInspectedEditor = false;
            }

            UiUtils.SetKeyword(useRimProp, useRimToggle);
            UiUtils.SetKeyword(useAnisotropicProp, useAnisotropicToggle);
            UiUtils.SetKeyword(useSSSProp, useSSSToggle);

            materialEditor.SetDefaultGUIWidths();

            UiUtils.PropertyFoldGroup("Texture", ref this.textureFold, () => 
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Texture"), textureProp); 
                materialEditor.TexturePropertySingleLine(new GUIContent("Toon Ramp"), toonRampProp); 
                materialEditor.ShaderProperty(baseColorProp, "Base Color");
                materialEditor.ShaderProperty(baseScrollRotateProp, "Base Scroll/Rotate");
                materialEditor.ShaderProperty(baseSpeedXYProp, "Base Speed(X/Y)");
                materialEditor.ShaderProperty(baseRotationPositionProp, "Base Rotation Position");
                materialEditor.ShaderProperty(baseCellOffsetProp, "Base Cell Offset");
                materialEditor.ShaderProperty(baseCellSharpnessProp, "Base Cell Sharpness");
                materialEditor.ShaderProperty(indirectDiffuseContributionProp, "Indirect Diffuse Contribution");
                materialEditor.ShaderProperty(highlightCellOffsetProp, "Highlight Cell Offset");
                materialEditor.ShaderProperty(highlightCellSharpnessProp, "Highlight Cell Sharpness");
                materialEditor.ShaderProperty(shadowContributionProp, "Shadow Contribution");
            });

            UiUtils.PropertyFoldGroup("Matcap", ref this.matcapFold, () => 
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Matcap"), matcapProp); 
            });

            UiUtils.PropertyFoldGroup("Parallax Mapping", ref this.midFold, () => 
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Mid"), midProp); 
                materialEditor.ShaderProperty(midColorProp, "Mid Color");
                materialEditor.ShaderProperty(midDepthScaleProp, "Mid Depth Scale");
                materialEditor.ShaderProperty(midScrollRotateProp, "Mid Scroll/Rotate");
                materialEditor.ShaderProperty(midSpeedXYProp, "Mid Speed(X/Y)");
                materialEditor.ShaderProperty(midRotationPositionProp, "Mid Rotation Position");
                materialEditor.TexturePropertySingleLine(new GUIContent("Back"), backProp); 
                materialEditor.ShaderProperty(backColorProp, "Back Color");
                materialEditor.ShaderProperty(backDepthScaleProp, "Back Depth Scale");
                materialEditor.ShaderProperty(backScrollRotateProp, "Back Scroll/Rotate");
                materialEditor.ShaderProperty(backSpeedXYProp, "Back Speed(X/Y)");
                materialEditor.ShaderProperty(backRotationPositionProp, "Back Rotation Position");
                materialEditor.TexturePropertySingleLine(new GUIContent("Mask"), maskProp); 
            });

            UiUtils.PropertyToggleFoldGroup("Rim Light", ref this.rimColorFold, ref this.useRimToggle, () => 
            {
                materialEditor.ShaderProperty(rimColorProp, "Rim Color");
                materialEditor.ShaderProperty(rimPowerProp, "Rim Power");
                materialEditor.ShaderProperty(rimOffsetProp, "Rim Offset");
            });

            UiUtils.PropertyFoldGroup("Normal", ref this.normalFold, () => 
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Normal"), normalProp); 
                materialEditor.ShaderProperty(normalScaleProp, "Normal Scale");
            });

            UiUtils.PropertyFoldGroup("Emission", ref this.emissionColorFold, () => 
            {
                materialEditor.ShaderProperty(emissionColorProp, "Emission Color");
                materialEditor.ShaderProperty(emissionIntensityProp, "Emission Intensity");
                materialEditor.TexturePropertySingleLine(new GUIContent("Emision Mask"), emisionMaskProp); 
            });

            UiUtils.PropertyFoldGroup("Specular", ref this.specularMapFold, () => 
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Specular Map"), specularMapProp); 
                materialEditor.ShaderProperty(specularTintProp, "Specular Tint");
            });

            UiUtils.PropertyToggleFoldGroup("Anisotropic", ref this.anisotropyXFold, ref this.useAnisotropicToggle, () => 
            {
                materialEditor.ShaderProperty(anisotropyXProp, "Anisotropy X");
                materialEditor.ShaderProperty(anisotropyYProp, "Anisotropy Y");
                materialEditor.ShaderProperty(anisotropyX2Prop, "Anisotropy X2");
                materialEditor.ShaderProperty(anisotropyY2Prop, "Anisotropy Y2");
                materialEditor.ShaderProperty(layer2BlendWeightProp, "Layer2 Blend Weight");
            });

            UiUtils.PropertyFoldGroup("Occulusion", ref this.occulusionMapFold, () => 
            {
                materialEditor.TexturePropertySingleLine(new GUIContent("Occulusion Map"), occulusionMapProp); 
                materialEditor.ShaderProperty(occulusionStrengthProp, "Occulusion Strength");
            });

            UiUtils.PropertyToggleFoldGroup("Subsurface Scattering (SSS)", ref this.sSSTypeFold, ref this.useSSSToggle, () => 
            {
                materialEditor.ShaderProperty(sSSTypeProp, "SSS Type");
                materialEditor.ShaderProperty(sSSMapProp, "SSS Map");
                materialEditor.ShaderProperty(sSSMultiplierProp, "SSS Multiplier");
                materialEditor.ShaderProperty(sSSColorProp, "SSS Color");
                materialEditor.ShaderProperty(sSSColorPowerProp, "SSS Color Power");
                materialEditor.ShaderProperty(sSSScaleProp, "SSS Scale");
                materialEditor.ShaderProperty(sSSPowerProp, "SSS Power");
                materialEditor.ShaderProperty(shadowStrengthProp, "Shadow Strength");
                materialEditor.ShaderProperty(pointLightPunchthroughProp, "Point Light Punchthrough");
                materialEditor.ShaderProperty(subsurfaceDistortionProp, "Subsurface Distortion");
            });

            UiUtils.PropertyFoldGroup("Transparency", ref this.maskClipValueFold, () => 
            {
                materialEditor.ShaderProperty(maskClipValueProp, "Mask Clip Value");
                materialEditor.ShaderProperty(opacityProp, "Opacity");
            });

            UiUtils.PropertyFoldGroup("Outline", ref this.outlineTintFold, () => 
            {
                materialEditor.ShaderProperty(outlineTintProp, "Outline Tint");
                materialEditor.ShaderProperty(outlineWidthProp, "Outline Width");
                materialEditor.ShaderProperty(tessValueProp, "Max Tessellation");
                materialEditor.ShaderProperty(tessMinProp, "Tess Min Distance");
                materialEditor.ShaderProperty(tessMaxProp, "Tess Max Distance");
                materialEditor.ShaderProperty(tessPhongStrengthProp, "Phong Tess Strength");
            });

            UiUtils.PropertyFoldGroup("Render Texture", ref this.renderTextureFold, () => 
            {
                materialEditor.ShaderProperty(renderTextureProp, "Render Texture");
                materialEditor.ShaderProperty(reflectionBlendProp, "Reflection Blend");
            });

            UiUtils.PropertyFoldGroup("Stencil Buffer", ref this.referenceFold, () => 
            {
                materialEditor.ShaderProperty(referenceProp, "Reference");
                materialEditor.ShaderProperty(readMaskProp, "Read Mask");
                materialEditor.ShaderProperty(writeMaskProp, "Write Mask");
                materialEditor.ShaderProperty(compFrontProp, "Comp. Front");
                materialEditor.ShaderProperty(passFrontProp, "Pass Front");
                materialEditor.ShaderProperty(failFrontProp, "Fail Front");
                materialEditor.ShaderProperty(zFailFrontProp, "ZFail Front");
                materialEditor.ShaderProperty(compBackProp, "Comp. Back");
                materialEditor.ShaderProperty(passBackProp, "Pass Back");
                materialEditor.ShaderProperty(failBackProp, "Fail Back");
                materialEditor.ShaderProperty(zFailBackProp, "ZFail Back");
            });

            UiUtils.PropertyFoldGroup("Blend", ref this.blendRGBSrcFold, () => 
            {
                materialEditor.ShaderProperty(blendRGBSrcProp, "Blend RGB Src");
                materialEditor.ShaderProperty(blendRGBDstProp, "Blend RGB Dst");
                materialEditor.ShaderProperty(blendOpRGBProp, "Blend Op RGB");
                materialEditor.ShaderProperty(blendAlphaSrcProp, "Blend Alpha Src");
                materialEditor.ShaderProperty(blendAlphaDstProp, "Blend Alpha Dst");
                materialEditor.ShaderProperty(blendOpAlphaProp, "Blend Op Alpha");
            });

            UiUtils.PropertyFoldGroup("Rendering", ref this.cullModeFold, () => 
            {
                materialEditor.ShaderProperty(cullModeProp, "Cull Mode");
                materialEditor.ShaderProperty(useLightColorProp, "Use Light Color");
                materialEditor.ShaderProperty(staticHighLightsProp, "Static HighLights");
            });



            UiUtils.PropertyFoldGroup("Other", ref this.renderingFold, () =>
            {
                materialEditor.RenderQueueField();
#if UNITY_5_6_OR_NEWER
                materialEditor.EnableInstancingField();
#endif
#if UNITY_5_6_2 || UNITY_5_6_3 || UNITY_5_6_4 || UNITY_2017_1_OR_NEWER
                materialEditor.DoubleSidedGIField();
#endif
                materialEditor.LightmapEmissionProperty();
            });
        }
    }

    private static void LoadMaterialProperties(Material material)
    {
        Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
        var data = EditorPrefs.GetString("24993c7fa6912af4784f3cffe8bd8466", string.Empty);
        if (string.IsNullOrEmpty(data)) return;

        var properties = data.Split(';');

        try
        {
            for (var i = 0; i < properties.Length; i++)
            {
                var values = properties[i].Split(':');
                if (values.Length != 3) return;
                if(!material.HasProperty(values[0])) return;

                var type = (ShaderUtil.ShaderPropertyType) Enum.Parse(typeof(ShaderUtil.ShaderPropertyType), values[1]);

                switch (type)
                {
                    case ShaderUtil.ShaderPropertyType.Color:
                        var colors = values[2].Split(',');
                        if(colors.Length != 4) break;
                        material.SetColor(values[0], new Color
                        (
                            Convert.ToSingle(colors[0]),
                            Convert.ToSingle(colors[1]),
                            Convert.ToSingle(colors[2]),
                            Convert.ToSingle(colors[3])
                        ));
                        break;
                    case ShaderUtil.ShaderPropertyType.Vector:
                        var vectors = values[2].Split(',');
                        if (vectors.Length != 4) break;
                        material.SetVector(values[0], new Color
                        (
                            Convert.ToSingle(vectors[0]),
                            Convert.ToSingle(vectors[1]),
                            Convert.ToSingle(vectors[2]),
                            Convert.ToSingle(vectors[3])
                        ));
                        break;
                    case ShaderUtil.ShaderPropertyType.Float:
                        material.SetFloat(values[0], Convert.ToSingle(values[2]));
                        break;
                    case ShaderUtil.ShaderPropertyType.Range:
                        material.SetFloat(values[0], Convert.ToSingle(values[2]));
                        break;
                    case ShaderUtil.ShaderPropertyType.TexEnv:
                        var testures = values[2].Split(',');
                        if(testures.Length != 5) break;
                        material.SetTexture(values[0], AssetDatabase.LoadAssetAtPath<Texture>(testures[0]));
                        material.SetTextureOffset(values[0], new Vector2
                        (
                            Convert.ToSingle(testures[1]),
                            Convert.ToSingle(testures[2])
                        ));
                        material.SetTextureScale(values[0], new Vector2
                        (
                            Convert.ToSingle(testures[3]),
                            Convert.ToSingle(testures[4])
                        ));
                        break;
                }
            }
        }
        catch (Exception e)
        {
            Debug.LogException(e);
        }
        Thread.CurrentThread.CurrentCulture = CultureInfo.CurrentUICulture;
    }

    private static void SaveMaterialProperties(Material material)
    {
        Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
        var shader = material.shader;
        var propertyCount = ShaderUtil.GetPropertyCount(shader);
        var data = string.Empty;

        for (var i = 0; i < propertyCount; i++)
        {
            var type = ShaderUtil.GetPropertyType(shader, i);
            var name = ShaderUtil.GetPropertyName(shader, i);
            var value = string.Empty;
            switch (type)
            {
                case ShaderUtil.ShaderPropertyType.Color:
                    var color = material.GetColor(name);
                    value = string.Format("{0},{1},{2},{3}", color.r, color.g, color.b, color.a);
                    break;
                case ShaderUtil.ShaderPropertyType.Vector:
                    var vector = material.GetVector(name);
                    value = string.Format("{0},{1},{2},{3}", vector.x, vector.y, vector.z, vector.w);
                    break;
                case ShaderUtil.ShaderPropertyType.Float:
                    value = material.GetFloat(name).ToString();
                    break;
                case ShaderUtil.ShaderPropertyType.Range:
                    value = material.GetFloat(name).ToString();
                    break;
                case ShaderUtil.ShaderPropertyType.TexEnv:
                    var texture = material.GetTexture(name);
                    value = AssetDatabase.GetAssetPath(texture);
                    var offset = material.GetTextureOffset(name);
                    var scale = material.GetTextureScale(name);
                    value += string.Format(",{0},{1},{2},{3}", offset.x, offset.y, scale.x, scale.y);
                    break;
            }

            data += string.Format("{0}:{1}:{2}", name, type, value);

            if (i < propertyCount - 1) data += ";";
        }

        EditorPrefs.SetString("24993c7fa6912af4784f3cffe8bd8466", data);
        Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture;
    }

        private static void SaveTemplateData(Material material)
        {
        Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
        var shader = material.shader;
        var propertyCount = ShaderUtil.GetPropertyCount(shader);
        var data = string.Empty;

        for (var i = 0; i < propertyCount; i++)
        {
            var type = ShaderUtil.GetPropertyType(shader, i);
            var name = ShaderUtil.GetPropertyName(shader, i);
            var value = string.Empty;
            switch (type)
            {
                case ShaderUtil.ShaderPropertyType.Color:
                    var color = material.GetColor(name);
                    value = string.Format("{0},{1},{2},{3}", color.r, color.g, color.b, color.a);
                    break;
                case ShaderUtil.ShaderPropertyType.Vector:
                    var vector = material.GetVector(name);
                    value = string.Format("{0},{1},{2},{3}", vector.x, vector.y, vector.z, vector.w);
                    break;
                case ShaderUtil.ShaderPropertyType.Float:
                    value = material.GetFloat(name).ToString();
                    break;
                case ShaderUtil.ShaderPropertyType.Range:
                    value = material.GetFloat(name).ToString();
                    break;
                case ShaderUtil.ShaderPropertyType.TexEnv:
                    var texture = material.GetTexture(name);
                    value = AssetDatabase.GetAssetPath(texture);
                    var offset = material.GetTextureOffset(name);
                    var scale = material.GetTextureScale(name);
                    value += string.Format(",{0},{1},{2},{3}", offset.x, offset.y, scale.x, scale.y);
                    break;
            }

            data += string.Format("{0}:{1}:{2}", name, type, value);


            if (i < propertyCount - 1) data += ";";
        }

        EditorPrefs.SetString("24993c7fa6912af4784f3cffe8bd8466", data);

        var filePath = EditorUtility.SaveFilePanel("Create New Isuzu Shader Template", Application.dataPath, "New IsuzuShaderTemplate", "shadertemp");

        if (string.IsNullOrEmpty(filePath)) return;

        using (var writer = new StreamWriter(filePath, false))
        {
            writer.Write(data);
            writer.Flush();
            writer.Close();
        }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

        Thread.CurrentThread.CurrentCulture = Thread.CurrentThread.CurrentUICulture;
        }

    private static void LoadTemplateData(Material material)
    {
        Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;

        var filePath = EditorUtility.OpenFilePanel("Select Isuzu Shader Template", Application.dataPath, "shadertemp");
        if (string.IsNullOrEmpty(filePath)) return;

        var data = string.Empty;
        using (var sr = new StreamReader(filePath))
        {
            data = sr.ReadToEnd();
            sr.Close();
        }

        if (string.IsNullOrEmpty(data)) return;

        var properties = data.Split(';');

        try
        {
            for (var i = 0; i < properties.Length; i++)
            {
                var values = properties[i].Split(':');
                if (values.Length != 3) return;
                if (!material.HasProperty(values[0])) return;

                var type = (ShaderUtil.ShaderPropertyType)Enum.Parse(typeof(ShaderUtil.ShaderPropertyType), values[1]);

                switch (type)
                {
                    case ShaderUtil.ShaderPropertyType.Color:
                        var colors = values[2].Split(',');
                        if (colors.Length != 4) break;
                        material.SetColor(values[0], new Color
                        (
                            Convert.ToSingle(colors[0]),
                            Convert.ToSingle(colors[1]),
                            Convert.ToSingle(colors[2]),
                            Convert.ToSingle(colors[3])
                        ));
                        break;
                    case ShaderUtil.ShaderPropertyType.Vector:
                        var vectors = values[2].Split(',');
                        if (vectors.Length != 4) break;
                        material.SetVector(values[0], new Color
                        (
                            Convert.ToSingle(vectors[0]),
                            Convert.ToSingle(vectors[1]),
                            Convert.ToSingle(vectors[2]),
                            Convert.ToSingle(vectors[3])
                        ));
                        break;
                    case ShaderUtil.ShaderPropertyType.Float:
                        material.SetFloat(values[0], Convert.ToSingle(values[2]));
                        break;
                    case ShaderUtil.ShaderPropertyType.Range:
                        material.SetFloat(values[0], Convert.ToSingle(values[2]));
                        break;
                    case ShaderUtil.ShaderPropertyType.TexEnv:
                        var testures = values[2].Split(',');
                        if (testures.Length != 5) break;
                        material.SetTexture(values[0], AssetDatabase.LoadAssetAtPath<Texture>(testures[0]));
                        material.SetTextureOffset(values[0], new Vector2
                        (
                            Convert.ToSingle(testures[1]),
                            Convert.ToSingle(testures[2])
                        ));
                        material.SetTextureScale(values[0], new Vector2
                        (
                            Convert.ToSingle(testures[3]),
                            Convert.ToSingle(testures[4])
                        ));
                        break;
                }
            }
        }
        catch (Exception e)
        {
            Debug.LogException(e);
        }
        Thread.CurrentThread.CurrentCulture = CultureInfo.CurrentUICulture;
    }
}


