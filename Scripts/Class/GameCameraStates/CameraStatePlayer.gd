extends CameraState
class_name CameraStatePlayer


func move(cam: Spatial, delta: float):
	if Global.player != null:
		cam.global_transform = Global.player.camera_root.global_transform
