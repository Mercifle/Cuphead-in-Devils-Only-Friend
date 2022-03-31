extends Node2D

onready var Chup = load("res://Prefab/MarchingChup.tscn")

func spawn():
	var ChupInstance = Chup.instance()
	ChupInstance.global_position = global_position
	get_tree().root.add_child(ChupInstance)
