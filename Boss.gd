extends KinematicBody2D

export var SPEED = 20

export var HealthPoints = 100

var ParentSpawner = null
var Speed = Vector2()

func Damage(amount):
	HealthPoints -= amount
	if HealthPoints <= 0:
		die()

func _process(delta):
	Speed.y += GRAVITY
	Speed.x = -SPEED
	Speed = move_and_slide(Speed)

func die():
	ParentSpawner.spawn()
	queue_free()
