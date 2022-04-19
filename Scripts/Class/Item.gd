extends Clickable
class_name Item


export(Texture) var icon
var item_name: String
var decription: String


func interact():
	if Global.player != null:
		Global.player.add_item(self)
		self.get_parent().remove_child(self)
