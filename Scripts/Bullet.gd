extends KinematicBody2D

export var Speed = 200

var Direction = 0

func set_dir(dir):
	Direction = dir

# TODO: Implement moving vertically and diagonally
func _process(delta):
	var vel = Vector2(Direction * Speed, 0)
	move_and_slide(vel)

func _on_Area2D_body_entered(body):
	queue_free()

func _on_Timer_timeout():
	queue_free()
