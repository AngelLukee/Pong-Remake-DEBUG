extends Node2D
class_name Habilidades

func DashHability(Player : CharacterBody2D):#Habilidade da coreia do sul
	
	if Input.is_action_pressed("down"):
		var tween = Player.create_tween()#Instanciando o create tween do proprio player, pois ele participa do nó
		tween.tween_property(Player, "position:y", Player.position.y + 160, 0.15)
		Player.UsarHabilidade = false
		
	if Input.is_action_pressed("up"):
		var tween = Player.create_tween()
		tween.tween_property(Player, "position:y", Player.position.y - 160, 0.15)
		Player.UsarHabilidade = false
		
func FlashBang(Player : CharacterBody2D) -> void:
	pass
