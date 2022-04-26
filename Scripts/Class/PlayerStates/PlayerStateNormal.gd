extends PlayerState
class_name PlayerStateNormal

var _motion: Vector3 = Vector3.ZERO
var _target_motion: Vector3 = Vector3.ZERO
var _result_motion: Vector3 = Vector3.ZERO
var _y_motion: float = 0.0

const SPEED: float = 5.0
const ACCELERATION: float = 5.0
const CAM_SPEED: float = 2.0
const CAM_MAX_ANGLE: float = PI/2
const CAM_MIN_ANGLE: float = -PI/2


func move(player: KinematicBody, orientation: Vector2, delta: float):
	self._target_motion = Vector3.ZERO
	self._target_motion.x = Controls.direction.x
	self._target_motion.z = Controls.direction.y
	self._target_motion = self._target_motion.normalized()
	self._target_motion = self._target_motion.rotated(Vector3.UP, orientation.y)
	self._target_motion *= self.SPEED
	
	self._motion = lerp( self._motion, self._target_motion, self.ACCELERATION * delta )
	
	self._result_motion = player.move_and_slide(self._motion, Vector3.UP)


func rotate(rotaion: Vector2, delta: float) -> Vector2:
	var res: Vector2 = rotaion + Controls.orientation * 0.01 * self.CAM_SPEED
	res.x = lerp_angle(res.x, rotaion.x, 1.0 * delta)
	res.x = max(self.CAM_MIN_ANGLE, min(self.CAM_MAX_ANGLE, res.x))
	res.y = lerp_angle(res.y, rotaion.y, 1.0 * delta)
	return res
