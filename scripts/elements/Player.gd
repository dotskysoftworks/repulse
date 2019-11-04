extends KinematicBody

export (float) var gravity = 9.8
export (float) var speed = 1.4
export (float) var jumpForce = 7.0
export (float) var drag = 12.0
export (bool) var enabled = false
export (bool) var gun_enabled = false

var velocity = Vector3()
onready var yaw = $CamYaw
onready var camera = $CamYaw/Camera
onready var gun = $CamYaw/Camera/Gun
onready var hud = $CamYaw/Camera/Gun/HUD

func _process(delta):
	
	if gun_enabled:
		gun.gun_enabled = true
	
	if enabled and gun.gun_enabled:
		gun.visible = true
		hud.visible = true
	else:
		gun.visible = false
		hud.visible = false

func get_input():
	
	var direction = Vector3()
	
	# note: use the damn transform bases
	if is_on_floor() and enabled:
		if Input.is_action_pressed("forward"):
			direction -= yaw.global_transform.basis.z
			
		if Input.is_action_pressed("backward"):
			direction += yaw.global_transform.basis.z
			
		if Input.is_action_pressed("strafe_left"):
			direction -= yaw.global_transform.basis.x
			
		if Input.is_action_pressed("strafe_right"):
			direction += yaw.global_transform.basis.x
	
		direction = direction.normalized()
		
		if Input.is_action_just_pressed("jump"):
			direction.y += 1
	
	return direction

func _input(event):
	
	if event is InputEventMouseMotion and enabled:
		return camera.on_mouse(event)

func _physics_process(delta):
	
	var direction = get_input()
	direction.x *= speed
	direction.z *= speed
	direction.y *= jumpForce
	
	velocity.y += delta * -gravity
	
	if is_on_floor():
		velocity = velocity.linear_interpolate(Vector3.ZERO, delta * drag)
	
	velocity = move_and_slide(velocity + direction, Vector3.UP)