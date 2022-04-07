extends Node2D

onready var Chup = load("res://Prefab/MarchingChup.tscn")
var NewlyInit = true

func spawn():
	$Timer.start()

func spawn_instance():
	var ChupInstance = Chup.instance()
	ChupInstance.ParentSpawner = self
	ChupInstance.global_position = global_position
	get_tree().root.add_child(ChupInstance)

func _on_VisibilityNotifier2D_viewport_entered(viewport):
	if NewlyInit:
		spawn_instance()
		NewlyInit = false

func _on_Timer_timeout():
	spawn_instance()
