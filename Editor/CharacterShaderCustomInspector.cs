﻿using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using NUnit.Framework;
using UnityEditor;
using UnityEngine;

namespace IsuzuShader.Editor
{
    ///<inheritdoc />
    public class CharacterShaderCustomInspector : ShaderGUI
    {
        #region Fields
        private bool renderingFold = false;
        private bool textureFold = false;
        private bool matcapFold = false;
        private bool parallaxFold = false;
        private bool rimFold = false;
        private bool normalFold = false;
        private bool emissionFold = false;
        private bool outlineFold = false;
        private bool specularFold = false;
        private bool occulusionFold = false;
        private bool stencilFold = false;
        private bool distortionFold = false;
        private bool reflectionFold = false;
        private bool tesserationFold = false;
        private bool otherFold = false;
        private bool anisotropicFold = false;
        private bool sssFold = false;
        private bool transparencyFold = false;

        private bool useLim = false;

        private readonly string currentVersion;
        private readonly string remoteVersion;

        private readonly DataController controller;
        #endregion

        public CharacterShaderCustomInspector()
        {
            // this.controller = new DataController();
            // this.otherFold = this.controller.IsNewVersionAvailable();
            // this.currentVersion = DataController.Instance.CurrentVersion;
            // this.remoteVersion = DataController.Instance.LatestVersion;
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

            if (properties.Any(x => x.name == UiUtils.Texture))
                UiUtils.PropertyFoldGroup("Texture", ref this.textureFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Texture"),
                        FindProperty(UiUtils.Texture, properties));
                    materialEditor.TexturePropertySingleLine(new GUIContent("Toon Ramp"),
                         FindProperty(UiUtils.ToonRamp, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BaseColor, properties), "Base Color");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BaseScrollRotate, properties),
                        "Base Scroll Rotate");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BaseSpeedXY, properties), "Base Speed X/Y");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BaseRotationPosition, properties),
                        "Base Rotation Position");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BaseCellOffset, properties),
                        "Base Cell Offset");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BaseCellSharpness, properties),
                        "Base Cell Sharpness");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.IndirectDiffuseContribution, properties),
                        "Indirect Diffuse Contribution");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.HighlightCellOffset, properties),
                        "Highlight Cell Offset");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.HighlightCellSharpness, properties),
                        "Highlight Cell Sharpness");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.ShadowContribution, properties),
                        "Shadow Contribution");
                });

            if (properties.Any(x => x.name == UiUtils.Matcap))
                UiUtils.PropertyFoldGroup("Matcap", ref this.matcapFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Matcap"),
                        FindProperty(UiUtils.Matcap, properties));
                });

            if (properties.Any(x => x.name == UiUtils.Mid))
                UiUtils.PropertyFoldGroup("Parallax Mapping", ref this.parallaxFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Mid"),
                        FindProperty(UiUtils.Mid, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.MidColor, properties), "Mid Color");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.MidDepthScale, properties), "Mid Depth Scale");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.MidScrollRotate, properties),
                        "Mid Scroll Rotate");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.MidSpeedXY, properties), "Mid Speed X/Y");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.MidRotationPosition, properties),
                        "Mid Rotation Position");

                    materialEditor.TexturePropertySingleLine(new GUIContent("Back"),
                        FindProperty(UiUtils.Back, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BackColor, properties), "Back Color");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BackDepthScale, properties),
                        "Back Depth Scale");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BackScrollRotate, properties),
                        "Back Scroll Rotate");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BackSpeedXY, properties), "Back Speed X/Y");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.BackRotationPosition, properties),
                        "Back Rotation Position");

                    materialEditor.TexturePropertySingleLine(new GUIContent("Mask"),
                        FindProperty(UiUtils.Mask, properties));
                });

            if (properties.Any(x => x.name == UiUtils.RimColor))
                UiUtils.PropertyFoldGroup("Rim Light", ref this.rimFold,() =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.RimColor, properties), "Rim Color");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.RimPower, properties), "Rim Power");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.RimOffset, properties), "Rim Offset");
                    var property = FindProperty(UiUtils.UseRim, properties);
                    useLim = property.floatValue > 0;
                    materialEditor.ShaderProperty(property, "Use Rim");
                });

            if (properties.Any(x => x.name == UiUtils.Normal))
                UiUtils.PropertyFoldGroup("Normal", ref this.normalFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal"),
                        FindProperty(UiUtils.Normal, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.NormalScale, properties), "Normal Scale");
                });

            if (properties.Any(x => x.name == UiUtils.EmissionColor))
                UiUtils.PropertyFoldGroup("Emission", ref this.emissionFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.EmissionColor, properties), "Emission Color");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.EmissionIntensity, properties),
                        "Emission Intensity");
                    materialEditor.TexturePropertySingleLine(new GUIContent("Emission Mask"),
                        FindProperty(UiUtils.EmisionMask, properties));
                });

            if (properties.Any(x => x.name == UiUtils.SpecularMap))
                UiUtils.PropertyFoldGroup("Specular", ref this.specularFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Specular Map"),
                        FindProperty(UiUtils.SpecularMap, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.Specular, properties), "Specular");
                    //materialEditor.ShaderProperty(FindProperty(UiUtils.IndirectSpecularContribution, properties),
                        //"Indirect Specular Contribution");
                });

            if (properties.Any(x => x.name == UiUtils.MaskClipValue))
                UiUtils.PropertyFoldGroup("Transparency", ref this.transparencyFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.MaskClipValue, properties), "Mask Clip Value");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.Opacity, properties), "Opacity");
                });

            if (properties.Any(x => x.name == UiUtils.AnisotropyX))
                UiUtils.PropertyFoldGroup("Anisotropic", ref this.anisotropicFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.AnisotropyX, properties), "Anisotropy X");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.AnisotropyY, properties), "Anisotropy Y");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.AnisotropyX2, properties), "Anisotropy X2");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.AnisotropyY2, properties), "Anisotropy Y2");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.Layer2BlendWeight, properties), "Layer2 Blend Weight");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.UseAnisotropy, properties), "Use Anisotropic");
                });

            if (properties.Any(x => x.name == UiUtils.OutlineTint))
                UiUtils.PropertyFoldGroup("Outline", ref this.outlineFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.OutlineTint, properties), "Outline Tint");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.OutlineWidth, properties), "Outline Width");
                });

            if (properties.Any(x => x.name == UiUtils.OcculusionMap))
                UiUtils.PropertyFoldGroup("Occulusion", ref this.occulusionFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("Occulusion Map"),
                        FindProperty(UiUtils.OcculusionMap, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.OcculusionStrength, properties),
                        "Occulusion Strength");
                });

            if (properties.Any(x => x.name == UiUtils.SSSMap))
                UiUtils.PropertyFoldGroup("Subsurface Scattering", ref this.sssFold, () =>
                {
                    materialEditor.TexturePropertySingleLine(new GUIContent("SSS Map"),
                        FindProperty(UiUtils.SSSMap, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.SSSColor, properties), "SSS Color");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.SSSScale, properties), "SSS Scale");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.SSSPower, properties), "SSS Power");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.SubsurfaceDistortion, properties), "Subsurface Distortion");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.UseSSS, properties), "Use SSS");
                });

            if (properties.Any(x => x.name == UiUtils.Distortion))
                UiUtils.PropertyFoldGroup("Distortion", ref this.distortionFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.Distortion, properties), "Distortion");
                    materialEditor.TexturePropertySingleLine(new GUIContent("Ditortion Normal"),
                        FindProperty(UiUtils.DitortionNormal, properties));
                    materialEditor.ShaderProperty(FindProperty(UiUtils.DistortionTiling, properties),
                        "Distortion Tiling");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.DistortionBlend, properties),
                        "Distortion Blend");
                });


            if (properties.Any(x => x.name == UiUtils.RenderTexture))
                UiUtils.PropertyFoldGroup("Render Texture Reflection", ref this.reflectionFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.RenderTexture, properties), "Render Texture");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.ReflectionBlend, properties),
                        "Reflection Blend");
                });


            if (properties.Any(x => x.name == UiUtils.Reference))
                UiUtils.PropertyFoldGroup("Stencil", ref this.stencilFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.Reference, properties), "Reference");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.ReadMask, properties), "Read Mask");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.WriteMask, properties), "Write Mask");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.CompFront, properties), "Comp Front");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.PassFront, properties), "Pass Front");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.FailFront, properties), "Fail Front");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.ZFailFront, properties), "ZFail Front");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.CompBack, properties), "Comp Back");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.PassBack, properties), "Pass Back");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.FailBack, properties), "Fail Back");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.ZFailBack, properties), "ZFail Back");
                });

            if (properties.Any(x => x.name == UiUtils.TessValue))
                UiUtils.PropertyFoldGroup("Tessellation", ref this.tesserationFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.TessValue, properties), "Tess Value");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.TessMin, properties), "Tess Min");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.TessMax, properties), "Tess Max");
                });

            if (properties.Any(x => x.name == UiUtils.CullMode))
                UiUtils.PropertyFoldGroup("Rendering", ref this.renderingFold, () =>
                {
                    materialEditor.ShaderProperty(FindProperty(UiUtils.CullMode, properties), "Cull Mode");
                    materialEditor.ShaderProperty(FindProperty(UiUtils.StaticHighLights, properties), "Static High Lights");
                    materialEditor.RenderQueueField();
#if UNITY_5_6_OR_NEWER
                    materialEditor.EnableInstancingField();
#endif
#if UNITY_5_6_2 || UNITY_5_6_3 || UNITY_5_6_4 || UNITY_2017_1_OR_NEWER
                    materialEditor.DoubleSidedGIField();
#endif
                    materialEditor.LightmapEmissionProperty();
                });

            // UiUtils.PropertyFoldGroup("Other", ref this.otherFold, () =>
            // {
            //     EditorGUILayout.LabelField("Current Version : ", this.currentVersion);
            //     EditorGUILayout.LabelField("Latest  Version : ", this.remoteVersion);

            //     GUILayout.Space(5);

            //     if (GUILayout.Button("Check Version"))
            //     {
            //         this.ChaeckForUpdate();
            //     }
            // });

            EditorGUI.EndChangeCheck();
        }

        // [InitializeOnLoadMethod]
        // private void ChaeckForUpdate()
        // {
        //     var newVersionText = "New version Available!\n" + this.currentVersion + " → " + this.remoteVersion;
        //     var stayVersionText = "Already updated!\n" + this.currentVersion;
        //     if (!this.controller.IsNewVersionAvailable())
        //     {
        //         EditorUtility.DisplayDialog("Check Version", stayVersionText, "OK");
        //     }
        //     else if (EditorUtility.DisplayDialog("Check Version", newVersionText, "OK", "Cancel"))
        //     {
        //         System.Diagnostics.Process.Start("https://github.com/isuzu-shiranui/Isuzu-s-shaders/releases");
        //     }
        // }

        private static void LoadMaterialProperties(Material material)
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.InvariantCulture;
            var data = EditorPrefs.GetString("67304ff086a54a09817cfd4e8a54aeda", string.Empty);
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

            EditorPrefs.SetString("67304ff086a54a09817cfd4e8a54aeda", data);
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

            EditorPrefs.SetString("67304ff086a54a09817cfd4e8a54aeda", data);

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
}


