using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GPUSkinningToggler : MonoBehaviour
{
    public int instancesToTest = 200;
    public GameObject skinnedMeshPrefab;

    public Button gpuButton;
    public Button cpuButton;

    private GameObject container;

    public Material gpuSkinningMat;

    void ResetContainer()
    {
        if (container != null)
            Destroy(container);

        container = new GameObject("Container");
    }

    void Start()
    {
        container = new GameObject("Container");
        gpuButton.onClick.AddListener( OnGpuToggle );
        cpuButton.onClick.AddListener( OnCpuToggle );
    }

    private void OnCpuToggle()
    {
        ResetContainer();
        var original = Instantiate(skinnedMeshPrefab);

        Debug.Log("Starting to use Unity default skinned mesh renderer...");
        for ( int i = 0; i < instancesToTest; i ++)
        {
            Instantiate(original, Random.insideUnitSphere * 10, Quaternion.identity, container.transform);
        }

        Destroy(original);
    }

    private void OnGpuToggle()
    {
        ResetContainer();
        var original = Instantiate(skinnedMeshPrefab);
        var gpu = original.AddComponent<GPUSkinningComponent>();
        gpu.gpuSkinningMat = gpuSkinningMat;

        Debug.Log("Starting to use pure GPU skinning...");
        for ( int i = 0; i < instancesToTest; i ++)
        {
            Instantiate(original, Random.insideUnitSphere * 10, Quaternion.identity, container.transform);
        }

        Destroy(original);
    }
}