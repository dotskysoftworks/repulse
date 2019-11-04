extends "Platform.gd"

export (float) var initialDelay = 0.0
export (String) var sequence = "1"
export (int) var bpm = 60

onready var sequences = sequence.split(",")

var initDelay: float
var switched = true
var current = 0
var delay = 0.0

func switch_platform(delta):
	
	var period = float(sequences[current]) / (bpm / 60.0)
	delay += delta
	if delay >= period:

		if switched:
			next = target
			interpolation = attack
		else:
			next = Vector3.ZERO
			interpolation = release
		
		switched = !switched
		current += 1
		
		if current >= sequences.size():
			current = 0
		
		delay -= period
	
	self.translation = self.translation.linear_interpolate(next, interpolation)

func _process(delta):

	var recDelay = float(initialDelay) / (bpm / 60.0)
	
	if enabled:
		if initDelay >= recDelay:
			switch_platform(delta)
		else:
			initDelay += delta