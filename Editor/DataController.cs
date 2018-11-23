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
        public string GetCurrentVersion()
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
                yield return request.SendWebRequest();

                while (!request.isDone) yield return 0;

                if (request.isHttpError || request.isNetworkError) Debug.LogError(request.error);
                var regex = new Regex("(?<=td id=\"LC1\".*?>).*?(?=<)");
                var match = regex.Match(request.downloadHandler.text);

                if(!match.Success) Debug.LogError("Not Found");

                requestFinishedAction(match.ToString());
            }           
        }

        public string GetRemoteVersion()
        {
            var remoteVersion = string.Empty;
            var enumerator = this.GetRemoteVersion(x => remoteVersion = x);

            if (enumerator != null) while (enumerator.MoveNext()) { }

            return remoteVersion;
        }

        public bool IsNewVersionAvailable()
        {
            var currentVersion = this.GetCurrentVersion();
            var remoteVersion = this.GetRemoteVersion();

            if (string.IsNullOrEmpty(remoteVersion)) return false;

            return new Version(currentVersion) < new Version(remoteVersion);
        }
    }
}