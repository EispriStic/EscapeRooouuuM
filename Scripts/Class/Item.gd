extends Clickable
class_name Item


export(Texture) var icon: Texture
export(String) var key: String = ""
var item_name: String = "An Item"
var decription: String = "What it does"


signal collected


func _on_clicked():
	if Global.player != null:
		Global.player.add_item(self)
		self.get_parent().remove_child(self)
		self.emit_signal("collected")
		self._on_collected()



func _on_collected():
	""" Rewrite me """
	pass
