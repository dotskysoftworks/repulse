extends Button

export (int) var loaded = 1

func on_loader_pressed():
	global.load_level(loaded)
