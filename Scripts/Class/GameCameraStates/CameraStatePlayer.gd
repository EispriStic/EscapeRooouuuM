extends CameraState
class_name CameraStatePlayer


func move(cam: Spatial, delta: float):
	if Global.player != null:
		cam.translation = Global.player.camera_root.translation
		cam.rotation = Global.player.camera_root.rotation
