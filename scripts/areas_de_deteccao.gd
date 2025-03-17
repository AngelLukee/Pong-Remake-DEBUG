extends Node2D



func _on_area_dificil_body_entered(body: Node2D) -> void:
	if body.name == "bolinha":
		$"../IA".areaDificil = true
		
