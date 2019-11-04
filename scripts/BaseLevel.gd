extends Spatial

export (int) var levelId = 0
export (int) var bpm = 60
export (String) var levelName = "placehldr"

onready var bgm = $BGM
onready var platforms = get_tree().get_nodes_in_group("Platform")
onready var intro = $LevelIntro
onready var player = $Player
onready var stateMenu = $StateMenu
onready var activator = $GunActivator
onready var hud = $Player/CamYaw/Camera/Gun/HUD

func _ready():
	global.check_fancy_graphics()
	
	for platform in platforms:
		if platform.is_in_group("SequencedPlatform"):
			platform.bpm = bpm

func _process(delta):
	intro.levelName = levelName

func on_intro_invisible():

	if not intro.visible:
		bgm.play()
		
		for platform in platforms:
			if platform.enabledOnStart:
				platform.enabled = true

		player.enabled = true
		stateMenu.enabled = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func on_body_entered(body):
	if body.is_in_group("Player"):
		stateMenu.fail()

func on_goal_entered(body):
	if body.is_in_group("Player"):

		if levelId > global.completed:
			global.completed = levelId
			
		stateMenu.complete()
		global.save_game()
