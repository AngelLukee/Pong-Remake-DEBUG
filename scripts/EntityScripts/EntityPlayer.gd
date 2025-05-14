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
@export var SpriteCongelado : Sprite2D
@export var pathfollow : PathFollow2D
@export var path : Path2D

#Variaveis 
var HabilidadeAtiva : bool = false
var nomeBandeira : String = "China"
var velocidade : int = 300

#Booleanos
var congelado : bool = false

func _process(delta: float) -> void:
	
	position.y = clampi(position.y, 100, 612)
	MatchBandeiras(delta)

func _physics_process(delta: float) -> void:
	pass
	


	if not congelado:
		MovimentacaoPlayer()
	if congelado:
		MovimentacaoCongelado()
	
	
	move_and_slide()
	
	if Input.is_action_just_pressed("UsarHabilidade"):
		HabilidadeAtiva = true
		

func MatchBandeiras(delta) -> void:
	
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
			habilidades.rota(Bola, pathfollow, delta, path)
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

func MovimentacaoCongelado():
	var direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 0.025)
	else:
		velocity.y = lerp(velocity.y, 0.0, 0.009)
		
		if velocity.y < 20 and velocity.y > -20:
			velocity.y = 0
