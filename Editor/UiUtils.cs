using System;
using System.Text;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEngine;
using UnityEngine.Assertions;

/// <summary>
/// UIに関するUtilityクラス
/// </summary>
public static class UiUtils
{
    /// <summary>
    /// チェックボックスのスタイル。
    /// </summary>
    private static readonly GUIStyle smallTickbox;

    /// <summary>
    /// オプションアイコンの黒い版
    /// </summary>
    private static readonly Texture2D paneOptionsIconDark;

    /// <summary>
    /// オプションアイコンの白い版
    /// </summary>
    private static readonly Texture2D paneOptionsIconLight;

    /// <summary>
    /// ヘッダーのオプションアイコン。
    /// エディタがPro版かで色を変える。
    /// </summary>
    private static Texture2D PaneOptionsIcon { get { return EditorGUIUtility.isProSkin ? paneOptionsIconDark : paneOptionsIconLight; } }

    /// <summary>
    ///黒ヘッダー
    /// </summary>
    private static readonly Color headerBackgroundDarkColor;

    /// <summary>
    ///白ヘッダー
    /// </summary>
    private static readonly Color headerBackgroundLightColor;

    /// <summary>
    /// ヘッダーの背景色。
    /// エディタがPro版かで色を変える。
    /// </summary>
    private static Color HeaderBackgroundColor { get { return EditorGUIUtility.isProSkin ? headerBackgroundDarkColor : headerBackgroundLightColor; } }

    static UiUtils()
    {
        smallTickbox = new GUIStyle("ShurikenToggle");

        paneOptionsIconDark = (Texture2D)EditorGUIUtility.Load("Builtin Skins/DarkSkin/Images/pane options.png");
        paneOptionsIconLight = (Texture2D)EditorGUIUtility.Load("Builtin Skins/LightSkin/Images/pane options.png");

        headerBackgroundDarkColor = new Color(0.1f, 0.1f, 0.1f, 0.2f);
        headerBackgroundLightColor = new Color(1f, 1f, 1f, 0.2f);
    }

    /// <summary>
    /// タイトル付きのカスタム折り畳みグループUI
    /// </summary>
    /// <param name="title">タイトル</param>
    /// <param name="foldField">たたまれているか</param>
    /// <param name="materialPropertyAction">グループ内のコンテンツ</param>
    public static void PropertyFoldGroup(string title, ref bool foldField, Action materialPropertyAction)
    {
        var backgroundRect = GUILayoutUtility.GetRect(1f, 17f);

        var labelRect = backgroundRect;
        labelRect.xMin += 32f;
        labelRect.xMax -= 20f;

        var foldoutRect = backgroundRect;
        foldoutRect.y += 1f;
        foldoutRect.width = 13f;
        foldoutRect.height = 13f;

        backgroundRect.xMin = 0f;
        backgroundRect.width += 4f;

        // Background
        EditorGUI.DrawRect(backgroundRect, HeaderBackgroundColor);

        // Title
        EditorGUI.LabelField(labelRect, new GUIContent(title), EditorStyles.boldLabel);

        // foldout
        foldField = GUI.Toggle(foldoutRect, foldField, GUIContent.none, EditorStyles.foldout);

        // Handle events
        var e = Event.current;

        if (e.type == EventType.MouseDown)
        {
            if (labelRect.Contains(e.mousePosition))
            {
                if (e.button == 0)
                    foldField = !foldField;
                e.Use();
            }
        }

        if (foldField)
        {
            using (new GUILayout.VerticalScope(GUI.skin.box))
            {
                materialPropertyAction();
            }
        }
        GUILayout.Space(1);
    }

    /// <summary>
    /// タイトル、トグル付きのカスタム折り畳みグループUI
    /// </summary>
    /// <param name="title">タイトル</param>
    /// <param name="foldField">たたまれているか</param>
    /// <param name="materialPropertyAction">グループ内のコンテンツ</param>
    internal static void PropertyToggleFoldGroup(string title, ref bool foldField, ref bool isActive, Action materialPropertyAction)
    {
        var backgroundRect = GUILayoutUtility.GetRect(1f, 17f);

        var labelRect = backgroundRect;
        labelRect.xMin += 32f;
        labelRect.xMax -= 20f;

        var foldoutRect = backgroundRect;
        foldoutRect.y += 1f;
        foldoutRect.width = 13f;
        foldoutRect.height = 13f;

        var toggleRect = backgroundRect;
        toggleRect.x += 16f;
        toggleRect.y += 2f;
        toggleRect.width = 13f;
        toggleRect.height = 13f;

        backgroundRect.xMin = 0f;
        backgroundRect.width += 4f;

        // Background
        EditorGUI.DrawRect(backgroundRect, HeaderBackgroundColor);

        // Title
        using (new EditorGUI.DisabledScope(!isActive))
        EditorGUI.LabelField(labelRect, new GUIContent(title), EditorStyles.boldLabel);

        // foldout
        foldField = GUI.Toggle(foldoutRect, foldField, GUIContent.none, EditorStyles.foldout);

        // Active checkbox
        isActive = GUI.Toggle(toggleRect, isActive, GUIContent.none, smallTickbox);

        // Handle events
        var e = Event.current;

        if (e.type == EventType.MouseDown)
        {
            if (labelRect.Contains(e.mousePosition))
            {
                if (e.button == 0)
                    foldField = !foldField;
                e.Use();
            }
        }

        if (foldField)
        {
            using (new EditorGUI.DisabledScope(!isActive))
            using (new GUILayout.VerticalScope(GUI.skin.box))
            {
                materialPropertyAction();
            }
        }
        GUILayout.Space(1);
    }

    internal static void SetKeyword(MaterialProperty property, bool on)
    {
        var keyword = property.name.ToUpperInvariant() + "_ON";
        foreach(Material target in property.targets)
        {
            if(on)  target.EnableKeyword(keyword);
            else  target.DisableKeyword(keyword);
        }
        property.floatValue = on ? 1.0f : 0.0f;
    }
}