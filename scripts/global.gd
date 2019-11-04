extends Node

# will be saved
var fancy = false
var completed = 0

var currentLevel = 0

const LEVELS = 2

func load_game():
	var save = File.new()
	
	if not save.file_exists("user://save.data"):
		return
	
	save.open("user://save.data", File.READ)
	var lines = parse_json(save.get_line())
	fancy = bool(lines["fancy"])
	completed = int(lines["completed"])
	save.close()

func reset_game():
	fancy = false
	completed = 0
	var save = Directory.new()
	save.remove("user://save.data")

func save_game():
	var save = File.new()
	save.open("user://save.data", File.WRITE)
	var save_dict = {
		"fancy" : fancy,
		"completed" : completed
	}
	save.store_line(to_json(save_dict))
	save.close()
	
func switch_to(sceneName):
	get_tree().change_scene("res://scenes/%s.tscn" % sceneName)

func return_to_menu():
	switch_to("menus/MainMenu")

func continue_game():
	load_level(completed + 1)

func load_level(level):
	switch_to("levels/%02d/main" % level)
	
func check_fancy_graphics():
	var graphics = get_tree().get_current_scene().find_node("FancyGraphics")
	if fancy:
		graphics.visible = true
	else:
		graphics.visible = false