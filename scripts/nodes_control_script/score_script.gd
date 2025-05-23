extends Control

#export das entidades
@export var player_1 : EntityPlayer
@export var player_2 : Player2
@export var cpu : EntityCPU
@export var ball : EntityBall

#export de pontuacao
@export var PontuaçãoPlayer : Label
@export var PontuaçãoIA : Label

#variaveis
var score : Array = [0,0]


func _on_area_esquerda_body_entered(body: Node2D) -> void:
	if body.name == "BolaBody":
		score[0] += 1
		if score[0] < 10:
			PontuaçãoIA.text = str(0) + str(score[0]) 
		else:
			PontuaçãoIA.text = str(score[0])
			
		reset_habilities(player_1, player_2, cpu)
		await get_tree().create_timer(1.5).timeout
		ball.randomSpawn()

func _on_area_direita_body_entered(body: Node2D) -> void:
	if body.name == "BolaBody":
		score[1] += 1
		if score[1] < 10:
			PontuaçãoPlayer.text = str(0) + str(score[1]) 
		else:
			PontuaçãoPlayer.text = str(score[1])
			
		await get_tree().create_timer(1.5).timeout
		reset_habilities(player_1, player_2, cpu)
		ball.randomSpawn()

func reset_habilities(player_1 : EntityPlayer, player_2 : Player2, cpu : EntityCPU):
	cpu.habilidade_ativa = false
	player_1.habilidade_ativa = false
	player_2.habilidade_ativa = false
