extends KinematicBody2D

export var Speed = 150
export var DamageAmount = 20

var Direction = Vector2()

func set_dir(dir):
	Direction = dir

# TODO: Implement moving vertically and diagonally
func _process(delta):
	var vel = Direction * Speed
	move_and_slide(vel)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		body.Damage(DamageAmount)
	
	queue_free()
