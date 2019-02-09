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
/// 2/10/2019 6:43:15 AMに自動生成されました。
/// このファイルをエディタで直接編集しないでください。
/// </summary>
public class CharacterShaderCustomInspector : ShaderGUI
{
    #region Fields
    private string texture = "_Texture"; 
    private string toonRamp = "_ToonRamp"; 
    private string baseColor = "_BaseColor"; 
    private string baseScrollRotate = "_BaseScrollRotate"; 
    private string baseSpeedXY = "_BaseSpeedXY"; 
    private string baseRotationPosition = "_BaseRotationPosition"; 
    private string baseCellOffset = "_BaseCellOffset"; 
    private string baseCellSharpness = "_BaseCellSharpness"; 
    private string indirectDiffuseContribution = "_IndirectDiffuseContribution"; 
    private string highlightCellOffset = "_HighlightCellOffset"; 
    private string highlightCellSharpness = "_HighlightCellSharpness"; 
    private string shadowContribution = "_ShadowContribution"; 
    private string matcap = "_Matcap"; 
    private string mid = "_Mid"; 
    private string midColor = "_MidColor"; 
    private string midDepthScale = "_MidDepthScale"; 
    private string midScrollRotate = "_MidScrollRotate"; 
    private string midSpeedXY = "_MidSpeedXY"; 
    private string midRotationPosition = "_MidRotationPosition"; 
    private string back = "_Back"; 
    private string backColor = "_BackColor"; 
    private string backDepthScale = "_BackDepthScale"; 
    private string backScrollRotate = "_BackScrollRotate"; 
    private string backSpeedXY = "_BackSpeedXY"; 
    private string backRotationPosition = "_BackRotationPosition"; 
    private string mask = "_Mask"; 
    private string rimColor = "_RimColor"; 
    private string rimPower = "_RimPower"; 
    private string rimOffset = "_RimOffset"; 
    private string useRim = "_UseRim"; 
    private string normal = "_Normal"; 
    private string normalScale = "_NormalScale"; 
    private string emissionColor = "_EmissionColor"; 
    private string emissionIntensity = "_EmissionIntensity"; 
    private string emisionMask = "_EmisionMask"; 
    private string specularMap = "_SpecularMap"; 
    private string specularTint = "_SpecularTint"; 
    private string anisotropyX = "_AnisotropyX"; 
    private string anisotropyY = "_AnisotropyY"; 
    private string anisotropyX2 = "_AnisotropyX2"; 
    private string anisotropyY2 = "_AnisotropyY2"; 
    private string layer2BlendWeight = "_Layer2BlendWeight"; 
    private string useAnisotropic = "_UseAnisotropic"; 
    private string occulusionMap = "_OcculusionMap"; 
    private string occulusionStrength = "_OcculusionStrength"; 
    private string sSSType = "_SSSType"; 
    private string sSSMap = "_SSSMap"; 
    private string sSSMultiplier = "_SSSMultiplier"; 
    private string sSSColor = "_SSSColor"; 
    private string sSSColorPower = "_SSSColorPower"; 
    private string sSSScale = "_SSSScale"; 
    private string sSSPower = "_SSSPower"; 
    private string shadowStrength = "_ShadowStrength"; 
    private string pointLightPunchthrough = "_PointLightPunchthrough"; 
    private string subsurfaceDistortion = "_SubsurfaceDistortion"; 
    private string useSSS = "_UseSSS"; 
    private string maskClipValue = "_MaskClipValue"; 
    private string opacity = "_Opacity"; 
    private string outlineTint = "_OutlineTint"; 
    private string outlineWidth = "_OutlineWidth"; 
    private string tessValue = "_TessValue"; 
    private string tessMin = "_TessMin"; 
    private string tessMax = "_TessMax"; 
    private string tessPhongStrength = "_TessPhongStrength"; 
    private string renderTexture = "_RenderTexture"; 
    private string reflectionBlend = "_ReflectionBlend"; 
    private string reference = "_Reference"; 
    private string readMask = "_ReadMask"; 
    private string writeMask = "_WriteMask"; 
    private string compFront = "_CompFront"; 
    private string passFront = "_PassFront"; 
    private string failFront = "_FailFront"; 
    private string zFailFront = "_ZFailFront"; 
    private string compBack = "_CompBack"; 
    private string passBack = "_PassBack"; 
    private string failBack = "_FailBack"; 
    private string zFailBack = "_ZFailBack"; 
    private string blendRGBSrc = "_BlendRGBSrc"; 
    private string blendRGBDst = "_BlendRGBDst"; 
    private string blendOpRGB = "_BlendOpRGB"; 
    private string blendAlphaSrc = "_BlendAlphaSrc"; 
    private string blendAlphaDst = "_BlendAlphaDst"; 
    private string blendOpAlpha = "_BlendOpAlpha"; 
    private string cullMode = "_CullMode"; 
    private string useLightColor = "_UseLightColor"; 
    private string staticHighLights = "_StaticHighLights"; 
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
    private bool renderingFold = false;
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

        EditorGUI.BeginChangeCheck();

        materialEditor.SetDefaultGUIWidths();

        UiUtils.PropertyFoldGroup("Texture", ref this.textureFold, () => {
            materialEditor.TexturePropertySingleLine(new GUIContent("Texture"), FindProperty(this.texture, properties)); 
            materialEditor.TexturePropertySingleLine(new GUIContent("Toon Ramp"), FindProperty(this.toonRamp, properties)); 
                materialEditor.ShaderProperty(FindProperty(this.baseColor, properties), "Base Color");
                materialEditor.ShaderProperty(FindProperty(this.baseScrollRotate, properties), "Base Scroll/Rotate");
                materialEditor.ShaderProperty(FindProperty(this.baseSpeedXY, properties), "Base Speed(X/Y)");
                materialEditor.ShaderProperty(FindProperty(this.baseRotationPosition, properties), "Base Rotation Position");
                materialEditor.ShaderProperty(FindProperty(this.baseCellOffset, properties), "Base Cell Offset");
                materialEditor.ShaderProperty(FindProperty(this.baseCellSharpness, properties), "Base Cell Sharpness");
                materialEditor.ShaderProperty(FindProperty(this.indirectDiffuseContribution, properties), "Indirect Diffuse Contribution");
                materialEditor.ShaderProperty(FindProperty(this.highlightCellOffset, properties), "Highlight Cell Offset");
                materialEditor.ShaderProperty(FindProperty(this.highlightCellSharpness, properties), "Highlight Cell Sharpness");
                materialEditor.ShaderProperty(FindProperty(this.shadowContribution, properties), "Shadow Contribution");
        });
        UiUtils.PropertyFoldGroup("Matcap", ref this.matcapFold, () => {
            materialEditor.TexturePropertySingleLine(new GUIContent("Matcap"), FindProperty(this.matcap, properties)); 
        });
        UiUtils.PropertyFoldGroup("Parallax Mapping", ref this.midFold, () => {
            materialEditor.TexturePropertySingleLine(new GUIContent("Mid"), FindProperty(this.mid, properties)); 
                materialEditor.ShaderProperty(FindProperty(this.midColor, properties), "Mid Color");
                materialEditor.ShaderProperty(FindProperty(this.midDepthScale, properties), "Mid Depth Scale");
                materialEditor.ShaderProperty(FindProperty(this.midScrollRotate, properties), "Mid Scroll/Rotate");
                materialEditor.ShaderProperty(FindProperty(this.midSpeedXY, properties), "Mid Speed(X/Y)");
                materialEditor.ShaderProperty(FindProperty(this.midRotationPosition, properties), "Mid Rotation Position");
            materialEditor.TexturePropertySingleLine(new GUIContent("Back"), FindProperty(this.back, properties)); 
                materialEditor.ShaderProperty(FindProperty(this.backColor, properties), "Back Color");
                materialEditor.ShaderProperty(FindProperty(this.backDepthScale, properties), "Back Depth Scale");
                materialEditor.ShaderProperty(FindProperty(this.backScrollRotate, properties), "Back Scroll/Rotate");
                materialEditor.ShaderProperty(FindProperty(this.backSpeedXY, properties), "Back Speed(X/Y)");
                materialEditor.ShaderProperty(FindProperty(this.backRotationPosition, properties), "Back Rotation Position");
            materialEditor.TexturePropertySingleLine(new GUIContent("Mask"), FindProperty(this.mask, properties)); 
        });
        UiUtils.PropertyFoldGroup("Rim Light", ref this.rimColorFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.rimColor, properties), "Rim Color");
                materialEditor.ShaderProperty(FindProperty(this.rimPower, properties), "Rim Power");
                materialEditor.ShaderProperty(FindProperty(this.rimOffset, properties), "Rim Offset");
                materialEditor.ShaderProperty(FindProperty(this.useRim, properties), "Use Rim");
        });
        UiUtils.PropertyFoldGroup("Normal", ref this.normalFold, () => {
            materialEditor.TexturePropertySingleLine(new GUIContent("Normal"), FindProperty(this.normal, properties)); 
                materialEditor.ShaderProperty(FindProperty(this.normalScale, properties), "Normal Scale");
        });
        UiUtils.PropertyFoldGroup("Emission", ref this.emissionColorFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.emissionColor, properties), "Emission Color");
                materialEditor.ShaderProperty(FindProperty(this.emissionIntensity, properties), "Emission Intensity");
            materialEditor.TexturePropertySingleLine(new GUIContent("Emision Mask"), FindProperty(this.emisionMask, properties)); 
        });
        UiUtils.PropertyFoldGroup("Specular", ref this.specularMapFold, () => {
            materialEditor.TexturePropertySingleLine(new GUIContent("Specular Map"), FindProperty(this.specularMap, properties)); 
                materialEditor.ShaderProperty(FindProperty(this.specularTint, properties), "Specular Tint");
        });
        UiUtils.PropertyFoldGroup("Anisotropic", ref this.anisotropyXFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.anisotropyX, properties), "Anisotropy X");
                materialEditor.ShaderProperty(FindProperty(this.anisotropyY, properties), "Anisotropy Y");
                materialEditor.ShaderProperty(FindProperty(this.anisotropyX2, properties), "Anisotropy X2");
                materialEditor.ShaderProperty(FindProperty(this.anisotropyY2, properties), "Anisotropy Y2");
                materialEditor.ShaderProperty(FindProperty(this.layer2BlendWeight, properties), "Layer2 Blend Weight");
                materialEditor.ShaderProperty(FindProperty(this.useAnisotropic, properties), "Use Anisotropic");
        });
        UiUtils.PropertyFoldGroup("Occulusion", ref this.occulusionMapFold, () => {
            materialEditor.TexturePropertySingleLine(new GUIContent("Occulusion Map"), FindProperty(this.occulusionMap, properties)); 
                materialEditor.ShaderProperty(FindProperty(this.occulusionStrength, properties), "Occulusion Strength");
        });
        UiUtils.PropertyFoldGroup("Subsurface Scattering", ref this.sSSTypeFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.sSSType, properties), "SSS Type");
            materialEditor.ShaderProperty(FindProperty(this.sSSMap, properties), "SSS Map");
                materialEditor.ShaderProperty(FindProperty(this.sSSMultiplier, properties), "SSS Multiplier");
                materialEditor.ShaderProperty(FindProperty(this.sSSColor, properties), "SSS Color");
                materialEditor.ShaderProperty(FindProperty(this.sSSColorPower, properties), "SSS Color Power");
                materialEditor.ShaderProperty(FindProperty(this.sSSScale, properties), "SSS Scale");
                materialEditor.ShaderProperty(FindProperty(this.sSSPower, properties), "SSS Power");
                materialEditor.ShaderProperty(FindProperty(this.shadowStrength, properties), "Shadow Strength");
                materialEditor.ShaderProperty(FindProperty(this.pointLightPunchthrough, properties), "Point Light Punchthrough");
                materialEditor.ShaderProperty(FindProperty(this.subsurfaceDistortion, properties), "Subsurface Distortion");
                materialEditor.ShaderProperty(FindProperty(this.useSSS, properties), "Use SSS");
        });
        UiUtils.PropertyFoldGroup("Transparency", ref this.maskClipValueFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.maskClipValue, properties), "Mask Clip Value");
                materialEditor.ShaderProperty(FindProperty(this.opacity, properties), "Opacity");
        });
        UiUtils.PropertyFoldGroup("Outline", ref this.outlineTintFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.outlineTint, properties), "Outline Tint");
                materialEditor.ShaderProperty(FindProperty(this.outlineWidth, properties), "Outline Width");
                materialEditor.ShaderProperty(FindProperty(this.tessValue, properties), "Max Tessellation");
                materialEditor.ShaderProperty(FindProperty(this.tessMin, properties), "Tess Min Distance");
                materialEditor.ShaderProperty(FindProperty(this.tessMax, properties), "Tess Max Distance");
                materialEditor.ShaderProperty(FindProperty(this.tessPhongStrength, properties), "Phong Tess Strength");
        });
        UiUtils.PropertyFoldGroup("Render Texture", ref this.renderTextureFold, () => {
            materialEditor.ShaderProperty(FindProperty(this.renderTexture, properties), "Render Texture");
                materialEditor.ShaderProperty(FindProperty(this.reflectionBlend, properties), "Reflection Blend");
        });
        UiUtils.PropertyFoldGroup("Stencil Buffer", ref this.referenceFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.reference, properties), "Reference");
                materialEditor.ShaderProperty(FindProperty(this.readMask, properties), "Read Mask");
                materialEditor.ShaderProperty(FindProperty(this.writeMask, properties), "Write Mask");
                materialEditor.ShaderProperty(FindProperty(this.compFront, properties), "Comp. Front");
                materialEditor.ShaderProperty(FindProperty(this.passFront, properties), "Pass Front");
                materialEditor.ShaderProperty(FindProperty(this.failFront, properties), "Fail Front");
                materialEditor.ShaderProperty(FindProperty(this.zFailFront, properties), "ZFail Front");
                materialEditor.ShaderProperty(FindProperty(this.compBack, properties), "Comp. Back");
                materialEditor.ShaderProperty(FindProperty(this.passBack, properties), "Pass Back");
                materialEditor.ShaderProperty(FindProperty(this.failBack, properties), "Fail Back");
                materialEditor.ShaderProperty(FindProperty(this.zFailBack, properties), "ZFail Back");
        });
        UiUtils.PropertyFoldGroup("Blend", ref this.blendRGBSrcFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.blendRGBSrc, properties), "Blend RGB Src");
                materialEditor.ShaderProperty(FindProperty(this.blendRGBDst, properties), "Blend RGB Dst");
                materialEditor.ShaderProperty(FindProperty(this.blendOpRGB, properties), "Blend Op RGB");
                materialEditor.ShaderProperty(FindProperty(this.blendAlphaSrc, properties), "Blend Alpha Src");
                materialEditor.ShaderProperty(FindProperty(this.blendAlphaDst, properties), "Blend Alpha Dst");
                materialEditor.ShaderProperty(FindProperty(this.blendOpAlpha, properties), "Blend Op Alpha");
        });
        UiUtils.PropertyFoldGroup("Rendering", ref this.cullModeFold, () => {
                materialEditor.ShaderProperty(FindProperty(this.cullMode, properties), "Cull Mode");
                materialEditor.ShaderProperty(FindProperty(this.useLightColor, properties), "Use Light Color");
                materialEditor.ShaderProperty(FindProperty(this.staticHighLights, properties), "Static HighLights");
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


        EditorGUI.EndChangeCheck();
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


