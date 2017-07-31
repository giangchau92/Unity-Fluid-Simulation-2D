using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LiquidManager : MonoBehaviour {
	public Vector3 direction;
	public Material _material;
	public Camera _liquidCamera;

	void OnRenderImage(RenderTexture src, RenderTexture dest) {
		RenderTexture _renderTexture = RenderTexture.GetTemporary(Screen.width, Screen.height, 32);
		RenderTexture.active = _renderTexture;
		GL.Clear (false, true, Color.clear);
		RenderTexture.active = null;

		_liquidCamera.targetTexture = _renderTexture;
		_liquidCamera.Render ();
		_liquidCamera.targetTexture = null;

		_material.SetTexture ("_LiquidTex", _renderTexture);

		Graphics.Blit(src, dest, _material);

		RenderTexture.ReleaseTemporary (_renderTexture);
	}

	public void RandomPhysic() {
		direction = Random.insideUnitCircle;

		float len = Physics2D.gravity.magnitude;
		Physics2D.gravity = direction.normalized * len;
	}
}
