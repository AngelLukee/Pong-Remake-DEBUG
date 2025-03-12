extends Node

@export var PontuaçãoIA : Label
@export var Bolinha : CharacterBody2D

var number_uni : int = 0 #Casa da unidade

func _on_area_esquerda_body_entered(body: Node2D) -> void:
	if body.name == "bolinha":
		number_uni += 1
		
		if number_uni < 10:
			PontuaçãoIA.text = str(0) + str(number_uni) 
		else:
			PontuaçãoIA.text = str(number_uni)
			
		Bolinha.global_position = Vector2(544, 288)
