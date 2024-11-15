using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseInputForRipple : MonoBehaviour
{
    [SerializeField] private MeshRenderer ripplePlane;

    private Vector2 _uvMouseInput;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButton(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            if(Physics.Raycast(ray, out RaycastHit hit))
            {
                _uvMouseInput = hit.textureCoord;
                ripplePlane.material.SetVector("_InputCentre", _uvMouseInput);
            }
        }
    }
}
