extends Control

export (String) var levelName = "lv"
var period = 0.0
onready var level = $LevelContainer/LevelName

func _process(delta):
	
	level.text = levelName
	level.chars = 8
	
	if period >= 3:
		level.retract = true
		period = 0
	elif level.retract and level.percent_visible <= 0:
		self.visible = false
	elif level.period >= 1:
		period += delta