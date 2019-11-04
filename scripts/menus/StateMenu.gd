extends Control

var paused = false
var enabled = false
var onState = false
onready var state = $MetaContainer/State
onready var next = $MetaContainer/OptionContainer/NextButton
onready var cb = $MetaContainer/OptionContainer/ContinueButton
onready var restart = $MetaContainer/OptionContainer/RestartButton
onready var bg = $BG
onready var hud = get_tree().get_nodes_in_group("HUD")

const THEME = "res://src/themes/%s.tres"

func _process(delta):
	
	if Input.is_action_just_pressed("pause") and enabled and not onState:
		check_pause()
		set_color()
		set_visibility(false, true, true)
		state.period = 0
		state.text = "Paused_"
		state.chars = 7

func check_pause():
	
	if paused:
		enable_hud()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		unpause()
	else:
		enable_hud(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause()
	visible = !visible
	paused = !paused

func pause():
	get_tree().paused = true
	
func unpause():
	get_tree().paused = false

func complete():
	onState = true
	check_pause()
	set_color()
	if global.completed < global.LEVELS:
		set_visibility(true, false, false)
	else:
		set_visibility()
	state.period = 0
	state.text = "Completed_"
	state.chars = 10

func fail():
	onState = true
	check_pause()
	set_color(true)
	set_visibility(false, false, true)
	state.period = 0
	state.text = "Failed_"
	state.chars = 7

func enable_hud(active = true):

	for obj in hud:
		obj.visible = active

func set_color(fail = false):
	
	if fail:
		bg.color = Color(0.8, 0, 0, 0.6)
		self.theme = load(THEME % "fail_theme")
	else:
		bg.color = Color(1, 1, 1, 0.6)
		self.theme = load(THEME % "default_theme")
		
func set_visibility(nextV = false, cbV = false, resV = false):
	
	next.visible = nextV
	cb.visible = cbV
	restart.visible = resV

func on_next_clicked():
	unpause()
	global.continue_game()

func on_continue_clicked():
	check_pause()

func on_restart_clicked():
	unpause()
	get_tree().reload_current_scene()

func on_exit_clicked():
	unpause()
	global.return_to_menu()