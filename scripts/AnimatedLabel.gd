extends Label

onready var chars = text.length()
onready var period = 0.0
onready var flashPeriod = 0.0
onready var retract = false
onready var flash = false

func _process(delta):

	if period > 1:
		period = 1
	elif retract:
		if period > 0:
			period -= delta
			if period < 0:
				period = 0
			percent_visible = period
		else:
			period = 0
	elif period < 1:
		period += delta
		percent_visible = period
	
	if period == 1:
		if flashPeriod >= 0.3:
			
			if flash:
				visible_characters = chars - 1
			else:
				visible_characters = chars
				
			flash = !flash
			flashPeriod = 0
			
		flashPeriod += delta
