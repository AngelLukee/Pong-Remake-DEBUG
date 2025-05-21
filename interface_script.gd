extends Control

var player_script = preload("res://scripts/EntityScripts/EntityCPU.gd")
var player_node = preload("res://scenes/EntityScenes/player.tscn").instantiate()



func player_player_pressed() -> void:
	var player = player_node.get_node(".")
	print(player)
	player.set_script(player_script)
	get_tree().change_scene_to_file("res://scenes/nó_principal.tscn")
	
	
