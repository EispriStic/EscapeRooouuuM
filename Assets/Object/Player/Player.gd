extends KinematicBody
class_name Player


onready var camera_root: Spatial = $ViewRoot/ViewTilt/CameraRoot
onready var _view_root: Spatial = $ViewRoot
onready var _view_tilt: Spatial = $ViewRoot/ViewTilt
onready var _ray: RayCast = $ViewRoot/ViewTilt/RayCast

var _orientation: Vector2 = Vector2.ZERO setget set_orientation

var state: PlayerState = PlayerStateNormal.new()
var _inventory: Array = []


func _ready():
	Global.set_player(self)


func _physics_process(delta: float):
	if self.state != null:
		self._orientation = self.state.rotate(self._orientation, delta)
		self.state.move(self, self._orientation, delta)


func _input(event: InputEvent):
	if Input.is_action_just_pressed("action"):
		var obj = self._ray.get_collider()
		if obj is Clickable:
			obj.interact()


func add_item(item: Item):
	if not (item in self._inventory):
		self._inventory.append(item)


func set_orientation(value: Vector2):
	if _orientation != value:
		_orientation = value
		if self._view_root and self._view_tilt:
			self._view_tilt.rotation.x = _orientation.x
			self._view_root.rotation.y = _orientation.y
