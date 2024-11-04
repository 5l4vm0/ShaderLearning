using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseInput : MonoBehaviour
{
    private Vector3 _touchStart;
    [SerializeField] private RotationTransformation _rotationTransRef;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButtonDown(0))
        {
            _touchStart = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y,10f));
            Debug.Log(_touchStart);
        }
        if(Input.GetMouseButton(0))
        {
            Vector3 movement = _touchStart - Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, 10f)) ;
           
            _rotationTransRef.rotation.x -= movement.y;
            _rotationTransRef.rotation.y += movement.x;

        }
        if (Input.GetMouseButtonUp(0))
        {

        }
    }



}
