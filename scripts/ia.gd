extends CharacterBody2D

@export var Bolinha : CharacterBody2D
@export var Velocidade : int = 250
#

func _physics_process(delta: float) -> void:
	var ball_pos = $"../bolinha".position
	var distance = self.position.y - ball_pos.y
	
	self.position.y -= distance * delta
	
	
	#Alterações a fazer, mudar a velocidade da ia.
