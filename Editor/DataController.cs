using System;
using System.Collections;
using System.IO;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.Networking;
using Version = System.Version;

namespace IsuzuShader.Editor
{
    public class DataController
    {
#pragma warning disable IDE1006 // 命名スタイル
        private static DataController instance;
#pragma warning restore IDE1006 // 命名スタイル

        public static DataController Instance
        {
            get
            {
                if (instance != null) return instance;
                instance = new DataController();
                return instance;
            }
        }

        public string CurrentVersion { get; set; }

        public string LatestVersion { get; set; }

        public DataController()
        {
            this.CurrentVersion = this.GetCurrentVersion();
            this.LatestVersion = this.GetRemoteVersion();
        }

        private string GetCurrentVersion()
        {
            var currentVersion = string.Empty;
            var versionTextPath = Application.dataPath + "/Isuzu's shaders/Character/version.txt";
            if (File.Exists(versionTextPath))
            {
                var versionFileLines = File.ReadAllLines(versionTextPath);
                if (versionFileLines.Length > 0) currentVersion = versionFileLines[0];
            }
            return currentVersion;
        }

        private IEnumerator GetRemoteVersion(Action<string> requestFinishedAction)
        {
            var url = "https://github.com/isuzu-shiranui/Isuzu-s-shaders/blob/master/Character/version.txt";
            using (var request = UnityWebRequest.Get(url))
            {
#if UNITY_2017
                yield return request.SendWebRequest();
#else
                yield return request.Send();
#endif


                while (!request.isDone) yield return 0;

                if (
#if UNITY_2017
                    request.isHttpError || request.isNetworkError
#else
                    request.responseCode == 400 || request.responseCode == 500
#endif
                     ) Debug.LogError(request.error);
                var regex = new Regex("(?<=td id=\"LC1\".*?>).*?(?=<)");
                var match = regex.Match(request.downloadHandler.text);

                if(!match.Success) Debug.LogError("Not Found");

                requestFinishedAction(match.ToString());
            }           
        }

        private string GetRemoteVersion()
        {
            var remoteVersion = string.Empty;
            var enumerator = this.GetRemoteVersion(x => remoteVersion = x);

            if (enumerator != null) while (enumerator.MoveNext()) { }

            return remoteVersion;
        }

        public bool IsNewVersionAvailable()
        {
            if (string.IsNullOrEmpty(this.LatestVersion) || string.IsNullOrEmpty(this.CurrentVersion)) return false;

            return new Version(this.CurrentVersion) < new Version(this.LatestVersion);
        }
    }
}