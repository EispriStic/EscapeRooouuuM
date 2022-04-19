extends Button
class_name ItemUiTemplate

onready var _icon_rect: TextureRect = $HBoxContainer/VBoxContainer/IconRect
onready var _label_name: Label = $HBoxContainer/VBoxContainer2/LabelName
onready var _label_desciption: Label = $HBoxContainer/VBoxContainer3/LabelDexcription


func set_icon(texture: Texture):
	self._icon_rect.texture = texture


func set_item_name(value: String):
	self._label_name.text = value


func set_description(value: String):
	self._label_desciption.text = value
