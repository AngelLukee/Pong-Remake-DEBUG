extends CharacterBody2D
class_name EntityPlayer


#instancia das classes e onreadys
@onready var Bandeira = Bandeiras.new()
@onready var habilidades = BandeirasHabilidades.new()
@onready var spriteTexture = $SpritePlayer

#Export das variaveis para pegar os nós
@export var CPU : CharacterBody2D
@export var Bola : StaticBody2D

#Variaveis 
var HabilidadeAtiva : bool = false
var nomeBandeira : String
var velocidade : int = 300

func _process(delta: float) -> void:
	MatchBandeiras()

func _physics_process(delta: float) -> void:
	
	MovimentacaoPlayer()
	move_and_slide()
	
	if Input.is_action_just_pressed("UsarHabilidade"):
		HabilidadeAtiva = true
		
	if HabilidadeAtiva:
		$"../Path2D/PathFollow2D".progress += delta * velocidade
		$"../BolaBody".global_position = $"../Path2D/PathFollow2D".global_position
		if $"../Path2D/PathFollow2D".progress_ratio == 1.0:
			$"../Path2D/PathFollow2D".progress_ratio = 0.0
			HabilidadeAtiva = false
		

func MatchBandeiras() -> void:
	
	if not HabilidadeAtiva:
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

func MovimentacaoPlayer():
	var direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 1)
	else:
		velocity.y = 0
