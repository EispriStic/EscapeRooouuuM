extends Node


var level: Level setget set_level
var player: Player setget set_player
var camera: GameCamera setget set_camera


func _ready():
	pass


func set_level(value: Level):
	if level != value:
		if level != null:
			level.disconnect("tree_exited", self, "_reset_level")
		level = value
		if level != null:
			level.connect("tree_exited", self, "_reset_level")


func _reset_level():
	self.player = null


func set_player(value: Player):
	if player != value:
		if player != null:
			player.disconnect("tree_exited", self, "_reset_player")
		player = value
		if player != null:
			player.connect("tree_exited", self, "_reset_player")


func _reset_player():
	self.player = null


func set_camera(value: GameCamera):
	if camera != value:
		if camera != null:
			camera.disconnect("tree_exited", self, "_reset_camera")
		camera = value
		if camera != null:
			camera.connect("tree_exited", self, "_reset_camera")


func _reset_camera():
	self.camera = null
