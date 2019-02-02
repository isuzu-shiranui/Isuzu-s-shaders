using System;
using UnityEditor;
using UnityEngine;

namespace IsuzuShader.Editor
{
    /// <summary>
    /// UIに関するUtilityクラス
    /// </summary>
    public static class UiUtils
    {
        #region PropertyNames
        public const string CullMode = "_CullMode";
        public const string Texture = "_Texture";
        public const string ToonRamp = "_ToonRamp";
        public const string BaseColor = "_BaseColor";
        public const string BaseScrollRotate = "_BaseScrollRotate";
        public const string BaseSpeedXY = "_BaseSpeedXY";
        public const string BaseRotationPosition = "_BaseRotationPosition";
        public const string Mid = "_Mid";
        public const string MidColor = "_MidColor";
        public const string MidDepthScale = "_MidDepthScale";
        public const string MidScrollRotate = "_MidScrollRotate";
        public const string MidSpeedXY = "_MidSpeedXY";
        public const string MidRotationPosition = "_MidRotationPosition";
        public const string Back = "_Back";
        public const string BackColor = "_BackColor";
        public const string BackDepthScale = "_BackDepthScale";
        public const string BackScrollRotate = "_BackScrollRotate";
        public const string BackSpeedXY = "_BackSpeedXY";
        public const string BackRotationPosition = "_BackRotationPosition";
        public const string Mask = "_Mask";
        public const string Matcap = "_Matcap";
        public const string RimColor = "_RimColor";
        public const string RimPower = "_RimPower";
        public const string RimOffset = "_RimOffset";
        public const string UseRim = "_UseRim";
        public const string Normal = "_Normal";
        public const string NormalScale = "_NormalScale";
        public const string EmissionColor = "_EmissionColor";
        public const string EmissionIntensity = "_EmissionIntensity";
        public const string EmisionMask = "_EmisionMask";
        public const string OutlineTint = "_OutlineTint";
        public const string OutlineWidth = "_OutlineWidth";
        public const string SpecularMap = "_SpecularMap";
        public const string Specular = "_SpecularTint";
        public const string OcculusionMap = "_OcculusionMap";
        public const string OcculusionStrength = "_OcculusionStrength";
        public const string Reference = "_Reference";
        public const string ReadMask = "_ReadMask";
        public const string WriteMask = "_WriteMask";
        public const string CompFront = "_CompFront";
        public const string PassFront = "_PassFront";
        public const string FailFront = "_FailFront";
        public const string ZFailFront = "_ZFailFront";
        public const string CompBack = "_CompBack";
        public const string PassBack = "_PassBack";
        public const string FailBack = "_FailBack";
        public const string ZFailBack = "_ZFailBack";
        public const string Distortion = "_Distortion";
        public const string DitortionNormal = "_DitortionNormal";
        public const string DistortionBlend = "_DistortionBlend";
        public const string DistortionTiling = "_DistortionTiling";
        public const string RenderTexture = "_RenderTexture";
        public const string ReflectionBlend = "_ReflectionBlend";
        public const string ShadowContribution = "_ShadowContribution";
        public const string BaseCellOffset = "_BaseCellOffset";
        public const string BaseCellSharpness = "_BaseCellSharpness";
        public const string IndirectDiffuseContribution = "_IndirectDiffuseContribution";
        public const string IndirectSpecularContribution = "_IndirectSpecularContribution";
        public const string HighlightCellOffset = "_HighlightCellOffset";
        public const string HighlightCellSharpness = "_HighlightCellSharpness";
        public const string TessValue = "_TessValue";
        public const string TessMin = "_TessMin";
        public const string TessMax = "_TessMax";
        public const string AnisotropyX = "_AnisotropyX";
        public const string AnisotropyY = "_AnisotropyY";
        public const string AnisotropyX2 = "_AnisotropyX2";
        public const string AnisotropyY2 = "_AnisotropyY2";
        public const string UseAnisotropy = "_UseAnisotropic";
        public const string Layer2BlendWeight = "_Layer2BlendWeight";
        public const string StaticHighLights = "_StaticHighLights";
        public const string SSSMap = "_SSSMap";
        public const string SSSColor = "_SSSColor";
        public const string SSSPower = "_SSSPower";
        public const string SSSScale = "_SSSScale";
        public const string UseSSS = "_UseSSS";
        public const string SubsurfaceDistortion = "_SubsurfaceDistortion";
        public const string MaskClipValue = "_MaskClipValue";
        public const string Opacity = "_Opacity";
        public const string SSSType = "_SSSType";
        public const string SSSMultiplier = "_SSSMultiplier";
        public const string ShadowStrength = "_ShadowStrength";
        public const string SSSColorPower = "_SSSColorPower";
        public const string PointLightPunchthrough = "_PointLightPunchthrough";
        public const string UseLightColor = "_UseLightColor";

        #endregion

        /// <summary>
        /// タイトル付きのカスタム折り畳みグループUI
        /// </summary>
        /// <param name="title">タイトル</param>
        /// <param name="foldField">たたまれているか</param>
        /// <param name="materialPropertyAction">グループ内のコンテンツ</param>
        public static void PropertyFoldGroup(string title, ref bool foldField, Action materialPropertyAction)
        {
            var style = new GUIStyle("ShurikenModuleTitle")
            {
                font = new GUIStyle(EditorStyles.label).font,
                border = new RectOffset(15, 7, 4, 4),
                fixedHeight = 22,
                contentOffset = new Vector2(20f, -2f),
                fontStyle = FontStyle.Bold
            };

            var rect = GUILayoutUtility.GetRect(16f, 22f, style);
            GUI.Box(rect, title, style);

            var e = Event.current;

            var toggleRect = new Rect(rect.x + 4f, rect.y + 2f, 13f, 13f);
            if (e.type == EventType.Repaint)
            {
                EditorStyles.foldout.Draw(toggleRect, false, false, foldField, false);
            }

            if (e.type == EventType.MouseDown && rect.Contains(e.mousePosition))
            {
                foldField = !foldField;
                e.Use();
            }

            if (foldField)
                using (new GUILayout.VerticalScope(GUI.skin.box))
                    materialPropertyAction();
        }

        /// <summary>
        /// タイトル付きのカスタム折り畳みグループUI
        /// </summary>
        /// <param name="title">タイトル</param>
        /// <param name="foldField">たたまれているか</param>
        /// <param name="materialPropertyAction">グループ内のコンテンツ</param>
        public static void PropertyBooleanFoldGroup(string title, ref bool foldField, ref bool isChaeck, Action materialPropertyAction)
        {
            var style = new GUIStyle("ShurikenModuleTitle")
            {
                font = new GUIStyle(EditorStyles.label).font,
                border = new RectOffset(15, 7, 4, 4),
                fixedHeight = 22,
                contentOffset = new Vector2(32f, -2f),
                fontStyle = FontStyle.Bold
            };

            var rect = GUILayoutUtility.GetRect(16f, 22f, style);
            GUI.Box(rect, title, style);

            var e = Event.current;

            var foldRect = new Rect(rect.x + 4f, rect.y + 2f, 13f, 13f);
            var toggleRect = new Rect(rect.x + 16f, rect.y + 2f, 13f, 13f);
            if (e.type == EventType.Repaint)
            {
                EditorStyles.toggle.Draw(toggleRect, false, false, isChaeck, false);
                EditorStyles.foldout.Draw(foldRect, false, false, foldField, false);
            }

            if (e.type == EventType.MouseDown)
            {
                if(foldRect.Contains(e.mousePosition))
                {
                    foldField = !foldField;
                    e.Use();
                }

                if(toggleRect.Contains(e.mousePosition))
                {
                    isChaeck = !isChaeck;
                    e.Use();
                }
            }

            if (foldField )
                using (new GUILayout.VerticalScope(GUI.skin.box))
                    materialPropertyAction();
        }
    }
}
