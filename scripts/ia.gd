extends CharacterBody2D

@export var Bolinha : CharacterBody2D
@export var Velocidade : float = 220.0 
@export var Suavizacao : float = 3.0  # Quanto maior, mais suave será o movimento
var areaDificil : bool = true


func _physics_process(delta : float) -> void:
	var ball_pos = $"../bolinha".position
	var target_y = ball_pos.y  # Posição desejada, faz com que tenha menos codigo e confusão ao executar

	#Lerp faz com que a ia se mova em direção a bolinha sem travamentos, de forma muito mais suave
	if(areaDificil == true):
		self.position.y = lerp(self.position.y, target_y, Suavizacao * delta)
