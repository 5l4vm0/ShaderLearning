using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotationTransformation : Transformation
{
    public Vector3 rotation;
    //public override Vector3 Apply(Vector3 point)
    //{
    //    float radZ = rotation.z * Mathf.Deg2Rad; //converting z rotation degree to radians as sin and cos function in unity expect angles in radians 
    //    float radY = rotation.y * Mathf.Deg2Rad;
    //    float radX = rotation.x * Mathf.Deg2Rad;

    //    float sinX = Mathf.Sin(radX);
    //    float cosX = Mathf.Cos(radX);

    //    float sinY = Mathf.Sin(radY);
    //    float cosY = Mathf.Cos(radY);

    //    float sinZ = Mathf.Sin(radZ);
    //    float cosZ = Mathf.Cos(radZ);

    //    Vector3 xAxis = new Vector3(
    //        cosY * cosZ,
    //        cosX *sinZ +sinX*sinY*cosZ,
    //        sinX * sinZ -cosX*sinY*cosZ
    //    );

    //    Vector3 yAxis = new Vector3(
    //        -cosY * sinZ,
    //        cosX * cosZ - sinX * sinY * sinZ,
    //        sinX * cosZ + cosX * sinY * sinZ
    //    );

    //    Vector3 zAxis = new Vector3(
    //        sinY,
    //        -sinX*cosY,
    //        cosX*cosY
    //    );

    //    //Return rotation applied to Z Axis
    //    //return new Vector3 (
    //    //    //x(1,0) + y(0,1) = x(cosZ, sinZ) + y(-sinZ, cosZ) = x*cosZ-y*sinZ, x*sinZ+y*cosZ
    //    //    point.x*cosZ - point.y*sinZ,
    //    //    point.x*sinZ + point.y*cosZ,
    //    //    point.z
    //    //);

    //    return xAxis * point.x + yAxis * point.y + zAxis * point.z;
    //}

    public override Matrix4x4 Matrix
    {
        get
        {
            float radZ = rotation.z * Mathf.Deg2Rad;
            float radY = rotation.y * Mathf.Deg2Rad;
            float radX = rotation.x * Mathf.Deg2Rad;

            float sinX = Mathf.Sin(radX);
            float cosX = Mathf.Cos(radX);

            float sinY = Mathf.Sin(radY);
            float cosY = Mathf.Cos(radY);

            float sinZ = Mathf.Sin(radZ);
            float cosZ = Mathf.Cos(radZ);

            Matrix4x4 matrix = new Matrix4x4();

            matrix.SetColumn(0, new Vector4(
                cosY * cosZ,
                cosX * sinZ + sinX * sinY * cosZ,
                sinX * sinZ - cosX * sinY * cosZ,
                0
            ));

            matrix.SetColumn(1,new Vector4(
                -cosY * sinZ,
                cosX * cosZ - sinX * sinY * sinZ,
                sinX * cosZ + cosX * sinY * sinZ,
                0
            ));

            matrix.SetColumn(2,new Vector4(
                sinY,
                -sinX * cosY,
                cosX * cosY,
                0
            ));
            matrix.SetColumn(3, new Vector4(0, 0, 0, 1));
            return matrix;

        }
    }
}
