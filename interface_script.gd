extends Control

var player_script = preload("res://scripts/EntityScripts/EntityCPU.gd")
var player_node = preload("res://scenes/EntityScenes/player.tscn").instantiate()



func player_player_pressed() -> void:
	ScriptGlobal.player_script_to_use = player_script
	get_tree().change_scene_to_file("res://scenes/nó_principal.tscn")
	
	
