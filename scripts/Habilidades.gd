extends CharacterBody2D
class_name Habilidades

func DashHability(Player):#Habilidade da coreia do sul
	if Input.is_action_pressed("down"):
		Player.position.y += 160
		
		Player.UsarHabilidade = false
	if Input.is_action_pressed("up"):
		Player.position.y -= 160
		
		Player.UsarHabilidade = false

func FlashBang(Player):
	
