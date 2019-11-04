extends RayCast

var gun_enabled = false
var detecting = false
onready var detect = $HUD/CenterContainer/Detect
onready var platforms = get_tree().get_nodes_in_group("Platform")

func _process(delta):

	check_ray()
	switch_hud()

func switch_hud():
	
	if detecting:
		detect.visible = true
	else:
		detect.visible = false
	
func check_ray():
	if self.is_colliding():
		var collider = self.get_collider()
		
		if collider != null:
			if collider.is_in_group("Trigger"):
				detecting = true
				
				if Input.is_action_just_pressed("engage") and gun_enabled:
					for platform in platforms:
						if collider.trigId == platform.platformId:
							platform.enabled = true
			
		else:
			detecting = false
	else:
		detecting = false