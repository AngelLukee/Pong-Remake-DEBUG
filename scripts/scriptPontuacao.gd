extends Control

@export var PontuaçãoPlayer : Label
@export var PontuaçãoIA : Label
@onready var Bola : EntityBall = $"../BolaBody"
@export var PLAYER : EntityPlayer
var score : Array = [0,0]


func _on_area_esquerda_body_entered(body: Node2D) -> void:
	if body.name == "BolaBody":
		print("Ok")
		score[0] += 1
		if score[0] < 10:
			PontuaçãoIA.text = str(0) + str(score[0]) 
		else:
			PontuaçãoIA.text = str(score[0])
			
		await get_tree().create_timer(1.5).timeout
		Bola.randomSpawn()

func _on_area_direita_body_entered(body: Node2D) -> void:
	if body.name == "BolaBody":
		score[1] += 1
		if score[1] < 10:
			PontuaçãoPlayer.text = str(0) + str(score[1]) 
		else:
			PontuaçãoPlayer.text = str(score[1])
			
		await get_tree().create_timer(1.5).timeout
		PLAYER.habilidadeAtiva = false
		Bola.randomSpawn()
