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
            }
        }

        //Assign the vertices in vertices array as mesh vertices
        mesh.vertices = vertices;

        int[] triangle = new int[xSize * 6 * ySize]; //xsize *6 cause there are xsize*6 vertices for 1 square
        
        for(int t = 0, v = 0, y = 0; y < ySize; y++, v++) // v is the index to the veritces array elements
        {
            for (int x = 0; x < xSize; x++, t += 6, v++) //t+=6 cause 1 square(2 triangels) used 6 vertice
            {
                triangle[t] = v;
                triangle[t + 1] = triangle[t + 4] = v + xSize + 1;//first vertex in next row
                triangle[t + 2] = triangle[t + 3] = v + 1;
                triangle[t + 5] = v + xSize + 2;
                yield return new WaitForSecondsRealtime(0.1f);
                mesh.triangles = triangle; //The mesh.triangles array is a list of triangles that contains indices into the vertex array.

            }
        }


        //2 triangles
        //triangle[0] = 0;
        //triangle[1] = triangle[4] = xSize + 1;//first vertex in next row
        //triangle[2] = triangle[3] = 1;
        //triangle[5] = xSize + 2;
        
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
