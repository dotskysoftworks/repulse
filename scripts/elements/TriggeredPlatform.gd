extends "Platform.gd"

func _process(delta):
	
	if enabled:
		interpolation = attack
		next = target
	else:
		interpolation = release
		next = Vector3.ZERO
	
	self.translation = self.translation.linear_interpolate(next, interpolation)