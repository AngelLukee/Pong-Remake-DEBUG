extends CharacterBody2D
class_name EntityCPU


var velocidade : int = 300
var congelado : bool = false

var habilidadeAtiva : bool = false
var nomeBandeira : String

@export var BallPosition : StaticBody2D


func _process(delta: float) -> void:
	global_position.y = clampi(global_position.y, 100, 612)
	
func _physics_process(delta: float) -> void:
	
	if not congelado:
		movimentacaoCPU(delta)
		
	if congelado:
		Congelado()
	
	move_and_slide()

func MatchBandeiras() -> void:
	
	if not habilidadeAtiva:
		return
	
	match nomeBandeira:#Não comparar objetos, e sim nomes e IDs
		"Alemanha":
			pass
		"Austria":
			pass
		"Brasil":
			pass
		"China":
			pass
		"Coreia":
			pass
		"HongKong":
			pass
		"Japao":
			pass
		"Portugal":
			pass
		"Suecia":
			pass

func Congelado():
	
	var direction = Input.get_axis("otherup", "otherdowm")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 0.025)
	else:
		velocity.y = lerp(velocity.y, 0.0, 0.009)
		
		if velocity.y < 20 and velocity.y > -20:
			velocity.y = 0
			
func movimentacaoCPU(delta):
	
	velocity.y = lerp(velocity.y, BallPosition.position.y - self.position.y * velocidade, 5 * delta)
	
