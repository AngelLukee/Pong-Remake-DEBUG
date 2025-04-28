extends Node

@onready var Player = $"../Playerbody"
@onready var CPU = $"../CPUBody"

var bandeira = Bandeiras.new()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		$".".visible = true
	if Input.is_action_just_pressed("despausar"):
		$".".visible = false

func _on_button_pressed() -> void:
	Player.sprite_texture = bandeira.Alemanha

func _on_button_2_pressed() -> void:
	Player.sprite_texture = bandeira.Brasil
