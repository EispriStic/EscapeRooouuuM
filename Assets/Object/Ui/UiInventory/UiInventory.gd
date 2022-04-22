extends Control
class_name UiInventory


onready var _layout_items: VBoxContainer = $HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/Panel/LayoutItem
var _elements: Array = []

const PRELOAD_ITEM = preload("res://Assets/Object/Ui/ItemUiTemplate/ItemUiTemplate.tscn")


func toggle():
	if self.visible:
		self.hide()
	else:
		self.show()


func _ready():
	self.hide()
	self.update()


func show():
	get_viewport().move_child(self, 0)
	self.visible = true


func hide():
	self.visible = false


func update():
	if Global.player != null:
		for e in self._elements:
			e.queue_free()
		
		for item in Global.player.get_inventory():
			var element: ItemUiTemplate = self.PRELOAD_ITEM.instance()
			self._elements.append(element)
			self._layout_items.add_child(element)
			element.set_icon(item.icon)
			element.set_item_name(item.item_name)
			element.set_description(item.decription)
