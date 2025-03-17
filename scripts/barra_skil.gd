extends ColorRect

@export var agulhaskill : ColorRect
var velocidade : int = 90
var direction : int = 1

func _process(delta: float) -> void:
	
	agulhaskill.position.x += direction * delta * velocidade
	
	if(agulhaskill.position.x >= 161):
		direction = -1
	if(agulhaskill.position.x <= 1):
		direction = 1
