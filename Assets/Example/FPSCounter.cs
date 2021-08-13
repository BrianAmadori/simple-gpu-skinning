using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;
using UnityEngine.UI;

public class FPSCounter : MonoBehaviour
{
    public Text text;

    void Update()
    {
        float fps = (1 / Time.smoothDeltaTime);
        float ms = Time.smoothDeltaTime * 1000;

        string fpsText = fps.ToString("N2", CultureInfo.InvariantCulture);
        string msText = ms.ToString("N2", CultureInfo.InvariantCulture);
        text.text = $"FPS: {fpsText}\nMS: {msText}";
    }
}