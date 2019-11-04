extends Control

onready var anim = $Anim

func _ready():
	anim.current_animation = "BootScreen"
	
func _process(delta):
	if anim.current_animation_position == 5:
		global.return_to_menu()