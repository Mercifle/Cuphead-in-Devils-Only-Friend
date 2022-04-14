extends KinematicBody2D

export var DashSpeed = 700
export var WalkSpeed = 500
export var Gravity   = 100
export var JumpSpeed = 400

var IsControllable = true
var Speed = Vector2()
var Direction = 0
var LastDirection = 1 # Right by default
var CanDash = false
onready var CheckYourPosition = global_position

func _process(_delta):
	if IsControllable:
		if is_on_floor():
			CanDash = true
		
		# TODO: This *should* allow us to hold the button down to fire
		# We need to implement a timer for this to work, though...
		if Input.is_action_just_pressed("fire_bul"):
			fire_bullet()
			$BulletSeperation.start()
		elif Input.is_action_just_released("fire_bul"):
			$BulletSeperation.stop()
			
		if Input.is_action_pressed("walk_left"):
			Speed.x = -WalkSpeed
			Direction = -1
			LastDirection = -1
		elif Input.is_action_pressed("walk_right"):
			Speed.x = WalkSpeed
			Direction = 1
			LastDirection = 1
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
		
		if Input.is_action_pressed("duck_mug"):
			scale.y = 0.2
			Speed.x = 0
		else:
			scale.y = 1
		
		$ParryArea.global_scale = Vector2(1, 1)
		
		if Input.is_action_just_pressed("dash_gas") and Direction != 0 and CanDash:
			dash()
			CanDash = false
	
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

onready var BULLET = load("res://Prefab/Bullet.tscn")
var HAND_DIST = 20

export var BULLET_SPREAD = 0.05

func fire_bullet():
	var bul = BULLET.instance()
	bul.set_dir(Vector2(LastDirection, rand_range(-BULLET_SPREAD, BULLET_SPREAD)))
	bul.global_position.y = $HandHeight.global_position.y
	bul.global_position.x = global_position.x + HAND_DIST * LastDirection
	get_tree().get_root().add_child(bul)

func _on_BulletSeperation_timeout():
	fire_bullet()

func die():
	$Camera2D/CanvasLayer/PopupPanel.popup_centered()
	get_tree().paused = true
	
	global_position = CheckYourPosition
	Speed = Vector2.ZERO

func _on_Button_pressed():
	get_tree().paused = false
	$Camera2D/CanvasLayer/PopupPanel.visible = false
	global_position = CheckYourPosition
