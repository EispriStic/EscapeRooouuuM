extends Control
class_name PlayerUi


onready var _cursor: TextureRect = $VBoxContainer/HBoxContainer/Cursor
onready var _label_action: Label = $VBoxContainer2/LabelAction


func _ready():
	self._cursor.visible = false
	self._label_action.visible = false


func show_action(object: Clickable):
	if object and object is Clickable:
		get_parent().move_child(self, 0)
		self._cursor.visible = true
		self._label_action.visible = true
		self._label_action.text = object.get_interaction_text()
	else:
		self._cursor.visible = false
		self._label_action.visible = false
