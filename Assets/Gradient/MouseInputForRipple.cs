using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseInputForRipple : MonoBehaviour
{
    [SerializeField] private MeshRenderer ripplePlane;
    
    private Vector2 _uvMouseInput;
    private Vector4[] _OldUvMouseInput = new Vector4[5];

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
                //ripplePlane.material.SetVectorArray("_InputCentre", _uvMouseInput);
            }
            StartCoroutine(UpdateSecondWave());
        }
    }

    IEnumerator UpdateSecondWave()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            if(Physics.Raycast(ray, out RaycastHit hit))
            {
                for(int i =0; i<5; i++)
                {
                    yield return new WaitForSeconds(0.05f*i);
                    _OldUvMouseInput[i] = hit.textureCoord;
                }
                ripplePlane.material.SetVectorArray("_InputCentre", _OldUvMouseInput);
                
            }
        
    }
}
