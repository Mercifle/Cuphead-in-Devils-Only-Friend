extends KinematicBody2D

export var GRAVITY = 20
export var SPEED = 20

export var HealthPoints = 20

var Speed = Vector2()

func Damage(amount):
	HealthPoints -= amount
	if HealthPoints <= 0:
		die()

func _process(delta):
	Speed.y += GRAVITY
	Speed.x = -SPEED
	Speed = move_and_slide(Speed)
	
	if global_position.y > 100:
		die()

func die():
	get_tree().root.get_children()[0].get_node("TestSpawner").spawn()
	
	queue_free()
