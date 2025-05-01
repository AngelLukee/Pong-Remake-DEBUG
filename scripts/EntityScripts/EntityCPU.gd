extends CharacterBody2D
class_name EntityCPU


@export var velocidade : int = 250
var congelado : bool = false

func _physics_process(delta: float) -> void:
	
	if not congelado:
		movimentacaoCPU(delta)
	else:
		Congelado()
		
	position.y = clampi(position.y, 108, 495)
	
	move_and_slide()

func Congelado():
	if not congelado:
		return
	
	var direction = Input.get_axis("otherup", "otherdowm")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 0.025)
	else:
		velocity.y = lerp(velocity.y, 0.0, 0.01)
		
		if velocity.y < 20 and velocity.y > -20:
			velocity.y = 0
			
func movimentacaoCPU(delta):
	var direction = Input.get_axis("otherup", "otherdowm")
	if direction:
		position.y += direction * velocidade * delta
