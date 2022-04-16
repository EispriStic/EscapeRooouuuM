extends Spatial
class_name Player


onready var camera_root: Spatial = $CameraRoot


func _ready():
	Global.set_player(self)
