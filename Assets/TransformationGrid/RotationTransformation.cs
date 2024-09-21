using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotationTransformation : Transformation
{
    public Vector3 rotation;
    public override Vector3 Apply(Vector3 point)
    {
        float radZ = rotation.z * Mathf.Deg2Rad; //converting z rotation degree to radians as sin and cos function in unity expect angles in radians 
        float sinZ = Mathf.Sin(radZ);
        float cosZ = Mathf.Cos(radZ);
        return new Vector3 (
            //x(1,0) + y(0,1) = x(cosZ, sinZ) + y(-sinZ, cosZ) = x*cosZ-y*sinZ, x*sinZ+y*cosZ
            point.x*cosZ - point.y*sinZ,
            point.x*sinZ + point.y*cosZ,
            point.z
        );
    }
}
