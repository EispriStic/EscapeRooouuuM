extends Spatial
class_name Level


func _ready():
	Global.set_level(self)
	var cam = load("res://Assets/Object/GameCamera/GameCamera.tscn").instance()
	self.add_child(cam)
