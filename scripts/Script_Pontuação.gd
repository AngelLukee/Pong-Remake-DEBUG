extends Node

@export var PontuaçãoPlayer : Label
@export var PontuaçãoIA : Label
@export var bolinha : CharacterBody2D
var score : Array = [0,0]


func _on_area_esquerda_body_entered(body: Node2D) -> void:
	
	if body.name == "BolaBody":
		$TimerParaSpawn.start()
		score[0] += 1
		
		if score[0] < 10:
			PontuaçãoIA.text = str(0) + str(score[0]) 
		else:
			PontuaçãoIA.text = str(score[0])
		

func _on_area_direita_body_entered(body: Node2D):
	
	if body.name == "BolaBody":
		$TimerParaSpawn.start()
		score[1] += 1
		
		if score[1] < 10:
			PontuaçãoPlayer.text = str(0) + str(score[1]) 
		else:
			PontuaçãoPlayer.text = str(score[1])
		

func _on_timer_para_spawn_timeout() -> void:
	$"../BolaBody".random_spawn()
