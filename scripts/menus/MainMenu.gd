extends Control

onready var startLabel = $MetaContainer/StartLabel
onready var menus = $MetaContainer/MenuContainer
onready var extra = $MetaContainer/ExtraContainer
onready var options = $MetaContainer/ExtraContainer/OptionContainer
onready var levels = $MetaContainer/ExtraContainer/LevelContainer

onready var selectLevel = $MetaContainer/MenuContainer/SelectLevelButton
onready var startButton = $MetaContainer/MenuContainer/StartButton
onready var fancyButton = $MetaContainer/ExtraContainer/OptionContainer/FancyButton

func _ready():
	
	global.load_game()
	
	startLabel.chars = 18
	if global.completed == 0:
		startButton.text = "Start"
		selectLevel.visible = false
	elif global.completed == global.LEVELS:
		startButton.visible = false
		selectLevel.visible = true
	else:
		startButton.text = "Continue"
		selectLevel.visible = true
	
	fancyButton.pressed = global.fancy

func _process(delta):
	
	if startLabel.visible and Input.is_action_just_pressed("ui_accept"):
		startLabel.retract = true
		
	if startLabel.percent_visible <= 0 and (levels.visible or options.visible) == false:
		startLabel.visible = false
		menus.visible = true

func on_start_clicked():
	global.continue_game()

func on_levels_clicked():
	menus.visible = false
	extra.visible = true
	levels.visible = true
	options.visible = false

func on_option_clicked():
	menus.visible = false
	extra.visible = true
	levels.visible = false
	options.visible = true

func on_exit_clicked():
	get_tree().quit()

# options menu
func fancy_button(fancy):
	if fancy:
		global.fancy = true
	else:
		global.fancy = false

func on_reset_clicked():
	global.reset_game()
	global.switch_to("menus/Boot")

func on_back_clicked():
	global.save_game()
	menus.visible = true
	extra.visible = false
	levels.visible = false
	options.visible = false
	