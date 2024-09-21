using System.Collections;
using System.Collections.Generic;
using UnityEngine;



[RequireComponent (typeof(MeshRenderer), typeof(MeshFilter))]
public class TransformationGrid : MonoBehaviour
{
    public Transform prefab;
    public int gridResolution = 10;
    Transform[] grid;
    List<Transformation> transformations;

    void Awake()
    {
        transformations = new List<Transformation>();

        grid = new Transform[gridResolution * gridResolution * gridResolution];
        
        for(int i=0, x =0; x < gridResolution; x++)
        {
            for(int y = 0; y < gridResolution; y++)
            {
                for(int z =0; z< gridResolution; z++, i++)
                {
                    grid[i] = CreateGridPoint(x, y, z);
                }
            }
        }
    }

    private void Update()
    {
        GetComponents<Transformation>(transformations); //This will fill this transfomation list with all components of type Transformation found 
        for (int i = 0, x = 0; x < gridResolution; x++)
        {
            for (int y = 0; y < gridResolution; y++)
            {
                for (int z = 0; z < gridResolution; z++, i++)
                {
                    grid[i].localPosition = TransformPoint(x, y, z);
                }
            }
        }
    }

    private Transform CreateGridPoint(int x,int y,int z)
    {
        Transform cube = Instantiate(prefab);
        cube.localPosition = GetCoordinates(x, y, z);
        cube.GetComponent<MeshRenderer>().material.color = new Color((float)x / gridResolution, (float)y / gridResolution, (float)z / gridResolution);
        return cube;
    }
    
    Vector3 GetCoordinates(int x, int y, int z) // Make the centre of the grid to 0,0,0
    {
        return new Vector3(x - (gridResolution - 1) / 2, y - (gridResolution - 1) / 2,z - (gridResolution - 1) / 2);
    }

    private Vector3 TransformPoint(int x, int y, int z)
    {
        Vector3 coordinates = GetCoordinates(x, y, z);
        for(int i =0; i < transformations.Count; i++)
        {
            coordinates = transformations[i].Apply(coordinates);
        }
        return coordinates;
    }
}
