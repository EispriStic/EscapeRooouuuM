extends Spatial
class_name GameCamera


var state: CameraState = CameraStatePlayer.new()


func _ready():
	Global.set_camera(self)


func _process(delta: float):
	if self.state != null:
		self.state.move(self, delta)
