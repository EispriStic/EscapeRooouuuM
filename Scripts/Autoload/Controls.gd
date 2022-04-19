extends Node

enum controlTypes {KEYBOARD, CONTROLLER}
var _currentController= controlTypes.KEYBOARD setget setCurrentController
signal controllerTypeChanged(type)

var direction: Vector2 = Vector2.ZERO

var orientation: Vector2 = Vector2.ZERO
var orientationSensibility: float
const DEFAULT_orientationSensibility: float = 0.5

const KEYBOARD_SENSIBILITY_MULTIPLIER: float = 0.45

var _lastMouseMouvement: Vector2 = Vector2.ZERO
const CONTROLLER_SENSIBILITY_MULTIPLIER: float = 2.2

var deadZone: float setget setDeadZone
const DEFAULT_DEADZONE: float = 0.18


#======================
#	Node Functions

func _ready():
	self.orientationSensibility = self.DEFAULT_orientationSensibility
	self.initDeadZone()
	self.setDeadZone( self.DEFAULT_DEADZONE )


func _input(event):
	if event is InputEventMouseMotion:
		self._lastMouseMouvement = event.relative
	
#	when the keyboard/mouse is touched, we swap the inputs
	if event is InputEventMouseMotion or event is InputEventMouseButton or event is InputEventKey :
		self.setCurrentController( self.controlTypes.KEYBOARD )
	
#	when a controller is touched, we swap the inputs
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		self.setCurrentController( self.controlTypes.CONTROLLER )


func _physics_process(_delta):
	self.updateOrientation()
	self.updateDirection()


#======================
#	Controller Type

func setCurrentController(type)-> void:
	if type in self.controlTypes.values():
		if type != _currentController:
			_currentController = type
			emit_signal("controllerTypeChanged", _currentController)


#======================
#	Direction

func updateDirection() -> void:
	if self._currentController == self.controlTypes.KEYBOARD:
		self.updateDirectionKeyboard()
	
	elif self._currentController == self.controlTypes.CONTROLLER:
		self.updateDirectionController()



func updateDirectionKeyboard()-> void:
	var x: float = Input.get_action_strength("left") - Input.get_action_strength("right") # Horizontal motion
	var y: float = Input.get_action_strength("up") - Input.get_action_strength("down") # Vertical motion
	
	self.direction.x = x
	self.direction.y = y
	
	self.direction = self.direction.normalized().clamped(1)

func updateDirectionController()-> void:
	var x: float = Input.get_action_strength("left") - Input.get_action_strength("right") # Horizontal motion
	var y: float = Input.get_action_strength("up") - Input.get_action_strength("down") # Vertical motion
	
	if self.isInDeadZone(x, y):
		self.direction = Vector2.ZERO
	else:
		self.direction.x = x
		self.direction.y = y
		self.direction = self.direction.normalized().clamped(1)


#======================
#	Orientation

func updateOrientation() -> void:
	if self._currentController == self.controlTypes.KEYBOARD:
		self.updateOrientationKeyboard()
	
	elif self._currentController == self.controlTypes.CONTROLLER:
		self.updateOrientationController()


func updateOrientationKeyboard() -> void:
	self.orientation.y = -1.0 * self._lastMouseMouvement.x * self.orientationSensibility * self.KEYBOARD_SENSIBILITY_MULTIPLIER # Horizontal motion
	self.orientation.x = self._lastMouseMouvement.y * self.orientationSensibility * self.KEYBOARD_SENSIBILITY_MULTIPLIER # Vertical motion
	
	if self._lastMouseMouvement != Vector2.ZERO:
		self._lastMouseMouvement = Vector2.ZERO


func updateOrientationController() -> void:
	var x: float = (Input.get_action_strength("look_right") - Input.get_action_strength("look_left")) # Horizontal motion
	var y: float = (Input.get_action_strength("look_down") - Input.get_action_strength("look_up")) # Vertical motion
	if self.isInDeadZone(x, y):
		self.orientation = Vector2.ZERO
	else:
		self.orientation = Vector2(x, y) * self.orientationSensibility * self.CONTROLLER_SENSIBILITY_MULTIPLIER


#======================
#	Deadzone

func initDeadZone():
	InputMap.action_set_deadzone("up", 0.0)
	InputMap.action_set_deadzone("down", 0.0)
	InputMap.action_set_deadzone("left", 0.0)
	InputMap.action_set_deadzone("right", 0.0)
	
	InputMap.action_set_deadzone("look_up", 0.0)
	InputMap.action_set_deadzone("look_down", 0.0)
	InputMap.action_set_deadzone("look_left", 0.0)
	InputMap.action_set_deadzone("look_right", 0.0)


func setDeadZone(value):
	value = max(0.0, min(100.0, value) )
	if value != deadZone:
		deadZone = value


func isInDeadZone(x: float, y: float) -> bool:
	return abs(x) < self.deadZone and abs(y) < self.deadZone

#======================
#	Debug

func debugStr() -> String:
	var res: String = ""
	res += "--\tControls.gd\t--" + "\n"
	res +="\tdirection : " + str(self.direction) + "\n"
	res +="\torientation : " + str(self.orientation) + "\n"
	res +="\torientation sensi : " + str(self.orientationSensibility) + "\n"
	res += "---------------------------\n\n"
	return res
