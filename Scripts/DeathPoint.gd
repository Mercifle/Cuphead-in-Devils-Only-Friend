extends Area2D

func _on_DeathPoint_body_entered(body):
	body.die()
