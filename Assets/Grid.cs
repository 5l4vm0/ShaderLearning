using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
public class Grid : MonoBehaviour
{
    public int xSize, ySize;
    Vector3[] vertices;
    Mesh mesh;

    void Start()
    {
        StartCoroutine(Generate());
    }

    IEnumerator Generate()
    {
        //Create a Vector3 array to store vertices
        vertices = new Vector3[(xSize + 1) * (ySize + 1)];

        //Get mesh filter component and give it a name
        mesh = GetComponent<MeshFilter>().mesh;
        mesh.name = "Procedural Grid";
        
        //Assign value into array
        for (int i=0, y = 0; y <= ySize; y++)
        {
            for(int x =0; x <= xSize; x++, i++)
            {
                vertices[i] = new Vector3(x,y);
                yield return new WaitForSecondsRealtime(0.1f);
            }
        }

        //Assign the vertices in vertices array as mesh vertices
        mesh.vertices = vertices;

        int[] triangle = new int[3];
        triangle[0] = 0;
        triangle[1] = 1;
        triangle[2] = xSize+1; //first vertex in next row
        mesh.triangles = triangle;
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.black;

        //Apply array value to draw Gizmo to visualise the vertice position
        if(vertices != null)
        {
            for (int i = 0; i < vertices.Length; i++)
            {
                Gizmos.DrawSphere(vertices[i], 0.1f);
            }
        }
    }
}
