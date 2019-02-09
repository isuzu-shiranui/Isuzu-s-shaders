using System;
using System.Text;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEngine;

/// <summary>
/// UIに関するUtilityクラス
/// </summary>
public static class UiUtils
{
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
}