extends CharacterBody2D
class_name EntityCPU


@export var velocidade : int = 250

func _physics_process(delta: float) -> void:

	var direction = Input.get_axis("otherup", "otherdowm")
	if direction:
		position.y += direction * velocidade * delta
		
	position.y = clampi(position.y, 108, 495)
