extends Area2D

onready var TIMER = get_parent().get_node("Timer")

var IsActive = true

func parry_slap():
	TIMER.start()
	get_parent().visible = false
	IsActive = false

func _on_Timer_timeout():
	get_parent().visible = true
	IsActive = true
