extends CharacterBody2D
class_name EntityPlayer


#instancia das classes e onreadys
@onready var Bandeira = Bandeiras.new()
@onready var habilidades = HabilidadesPlayer.new()
@onready var spriteTexture = $SpritePlayer



#Export das variaveis para pegar os nós
@export var CPU : CharacterBody2D
@export var Bola : CharacterBody2D
@export var Sound : Node

#Variaveis 
var HabilidadeAtiva : bool = false
var nomeBandeira : String = "China"
var velocidade : int = 300

func _process(delta: float) -> void:
	position.y = clampi(position.y, 100, 612)
	MatchBandeiras()

func _physics_process(delta: float) -> void:
	
	MovimentacaoPlayer()
	move_and_slide()
	
	if Input.is_action_just_pressed("UsarHabilidade"):
		HabilidadeAtiva = true
		
	if HabilidadeAtiva:
		MatchBandeiras()

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
			habilidades.dash(self)
			HabilidadeAtiva = false
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
