extends KinematicBody2D

export var DashSpeed = 700
export var WalkSpeed = 500
export var Gravity   = 100
export var JumpSpeed = 400

var IsControllable = true
var Speed = Vector2()
var Direction = 0

func _process(_delta):
	if IsControllable:
		if Input.is_action_pressed("walk_left"):
			Speed.x = -WalkSpeed
			Direction = -1
		elif Input.is_action_pressed("walk_right"):
			Speed.x = WalkSpeed
			Direction = 1
		else:
			Speed.x = 0
			Direction = 0
		
		var ParryObjOrNull = get_parry_object()
		var CanParry = ParryObjOrNull != null
		
		if Input.is_action_just_pressed("jump_spin") and (is_on_floor() or CanParry):
			if CanParry:
				ParryObjOrNull.parry_slap()
			Speed.y = -JumpSpeed
		else:
			Speed.y += Gravity
		
		if Input.is_action_just_pressed("dash_gas") and Direction != 0:
			dash()
	
	# Dashing
	else:
		if Input.is_action_just_pressed("dash_gas"):
			dash_cancel()
	
	Speed = move_and_slide(Speed, Vector2.UP)

func get_parry_object():
	var ParryObj = null
	var Areas = $ParryArea.get_overlapping_areas()
	for A in Areas:
		if A.is_in_group("Parriable") and A.IsActive:
			ParryObj = A
	
	return ParryObj

func dash():
	Speed.x = DashSpeed * Direction
	Speed.y = 0
	IsControllable = false
	$DashTimer.start()

func dash_cancel():
	IsControllable = true
	$DashTimer.stop()
	
func _on_DashTimer_timeout():
	dash_cancel()
