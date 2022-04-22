extends StaticBody
class_name Clickable


var active: bool = true setget set_active


signal clicked


func interact():
	if self.active:
		self.emit_signal("clicked")
		self._on_clicked()


func _on_clicked():
	""" Rewrite me """
	pass



func set_active(value: bool):
	if active != value:
		active = value
