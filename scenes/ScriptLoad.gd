extends Node2D

func _ready() -> void:
	var habilidades = preload("res://scripts/Habilidades.gd").new()
	add_child(habilidades)
