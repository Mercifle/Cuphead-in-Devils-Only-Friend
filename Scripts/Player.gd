extends KinematicBody2D

export var WalkSpeed = 500
export var Gravity   = 100
export var JumpSpeed = 400

var Speed = Vector2()

func _process(_delta):
	if Input.is_action_pressed("walk_left"):
		Speed.x = -WalkSpeed
	elif Input.is_action_pressed("walk_right"):
		Speed.x = WalkSpeed
	else:
		Speed.x = 0
	
	# Check if we can parry
	var CanParry = false
	var Areas = $ParryArea.get_overlapping_areas()
	for A in Areas:
		if A.is_in_group("Parriable"):
			CanParry = true
	
	if Input.is_action_just_pressed("jump_spin") and (is_on_floor() or CanParry):
		Speed.y = -JumpSpeed
	else:
		Speed.y += Gravity
	
	Speed = move_and_slide(Speed, Vector2.UP)
