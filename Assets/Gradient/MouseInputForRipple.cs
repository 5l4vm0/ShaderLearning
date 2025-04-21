using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseInputForRipple : MonoBehaviour
{
    [SerializeField] private MeshRenderer ripplePlane;
    private Vector4[] ripplePoints = new Vector4[10];
    private int rippleIndex = 0;

    // Update is called once per frame
    void FixedUpdate()
    {
        if(Input.GetMouseButton(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            if(Physics.Raycast(ray, out RaycastHit hit))
            {
                ripplePoints[rippleIndex] = new Vector4(hit.textureCoord.x,hit.textureCoord.y, Time.time,0);
                rippleIndex = (rippleIndex + 1) % ripplePoints.Length;
            }
            ripplePlane.material.SetVectorArray("_InputCentre", ripplePoints);
        }
    }
}
