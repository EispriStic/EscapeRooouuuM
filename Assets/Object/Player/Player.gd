extends KinematicBody
class_name Player


onready var camera_root: Spatial = $ViewRoot/ViewTilt/CameraRoot
onready var _view_root: Spatial = $ViewRoot
onready var _view_tilt: Spatial = $ViewRoot/ViewTilt
onready var _ray: RayCast = $ViewRoot/ViewTilt/RayCast

var _orientation: Vector2 = Vector2.ZERO setget set_orientation

var state: PlayerState = PlayerStateNormal.new()
var _inventory: Array = []

var _inventory_ui: UiInventory
var _ui: PlayerUi

const PRELOAD_UIINVENTORY = preload("res://Assets/Object/Ui/UiInventory/UiInventory.tscn")
const PRELOAD_UI = preload("res://Assets/Object/Ui/PlayerUi/PlayerUi.tscn")


func _ready():
	Global.set_player(self)
	self._inventory_ui = self.PRELOAD_UIINVENTORY.instance()
	get_viewport().call_deferred("add_child", self._inventory_ui)
	self._inventory_ui.update()
	
	self._ui = self.PRELOAD_UI.instance()
	get_viewport().call_deferred("add_child", self._ui)


func _exit_tree():
	self._inventory_ui.queue_free()
	self._inventory_ui = null
	self._ui.queue_free()
	self._ui = null


func _process(delta: float):
	if self._ui and self._ray:
		self._ui.show_action(self._ray.get_collider())


func _physics_process(delta: float):
	if self.state != null and not self._inventory_ui.visible:
		self._orientation = self.state.rotate(self._orientation, delta)
		self.state.move(self, self._orientation, delta)


func _input(event: InputEvent):
	if Input.is_action_just_pressed("action") and not self._inventory_ui.visible:
		var obj = self._ray.get_collider()
		if obj is Clickable:
			obj.interact()
	
	elif Input.is_action_just_pressed("inventory"):
		if self._inventory_ui:
			self._inventory_ui.toggle()


func add_item(item: Item):
	if not (item in self._inventory):
		self._inventory.append(item)
		self._inventory_ui.update()


func remove_item(item: Item):
	if item in self._inventory:
		self._inventory.remove( self._inventory.bsearch(item) )
		self._inventory_ui.update()


func set_orientation(value: Vector2):
	if _orientation != value:
		_orientation = value
		if self._view_root and self._view_tilt:
			self._view_tilt.rotation.x = _orientation.x
			self._view_root.rotation.y = _orientation.y


func get_inventory() -> Array:
	return self._inventory
