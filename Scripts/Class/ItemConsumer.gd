extends Clickable
class_name ItemConsumer


export(String) var required_item_key: String = ""


signal activated


func get_interaction_text() -> String:
	return "Use something on me"


func _on_clicked():
	if Global.player:
		for item in Global.player.get_inventory():
			if item.key == self.required_item_key:
				Global.player.remove_item(item)
				self.emit_signal("activated")
				self._on_activated()
				return


func _on_activated():
	""" rewrite me """
	pass
