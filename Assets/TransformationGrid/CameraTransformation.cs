using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraTransformation : Transformation
{
    public override Matrix4x4 Matrix
    {
        get
        {
            Matrix4x4 matrix = new Matrix4x4();
            matrix.SetRow(0, new Vector4(1, 0, 0, 0));
            matrix.SetRow(1, new Vector4(0, 1, 0, 0));
            matrix.SetRow(2, new Vector4(0, 0, 0, 0)); //drop Z dimension
            matrix.SetRow(3, new Vector4(0, 0, 1, 0));
            return matrix;
        }
    }
}
