extends Camera

onready var yaw = get_parent()
var sensitivity = 10

func adjust_pitch(rotation = 0):
	
	var pitch = self.get_rotation() + Vector3(rotation, 0, 0)
	pitch.x = clamp(pitch.x, PI / -2, PI / 2)
	
	return pitch
	
func adjust_yaw(rotation = 0):
	
	return yaw.get_rotation() + Vector3(0, rotation, 0)
	
func on_mouse(event):
	
	yaw.set_rotation(adjust_yaw(event.relative.x / (sensitivity * -10)))
	self.set_rotation(adjust_pitch(event.relative.y / (sensitivity * -10)))
