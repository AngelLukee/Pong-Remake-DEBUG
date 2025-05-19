extends CharacterBody2D
class_name EntityPlayer

#instancia das classes e onreadys
@onready var habilidades = HabilidadesPlayer.new()


#Export das variaveis para pegar os nós
@export var CPU : CharacterBody2D
@export var BALL : EntityBall
@export var Sound : Node
@export var SpriteCongelado : Sprite2D
@export var cooldown : Timer
@export var pathfollow : PathFollow2D
@export var path : Path2D
@export var pointlight : PointLight2D
@export var LINHA : Line2D
@export var PATHMAKER : Path2D
@export var FOLLOWMAKER : PathFollow2D
@export var ima : Sprite2D


#Variaveis 
var habilidadeAtiva : bool = false
var nomeBandeira : String = "China"
var velocidade : int = 300

#Booleanos
var congelado : bool = false
var iniciar : bool = false


func _process(delta: float) -> void:
	
	global_position.x = clampi(global_position.x, 102, 102)
	global_position.y = clampi(global_position.y, 100, 612)
	
		

func _physics_process(delta: float) -> void:
	MatchBandeiras(delta)
	
	if iniciar:
		FOLLOWMAKER.progress += delta * BALL.ballVelocity
		BALL.global_position = FOLLOWMAKER.global_position
	if FOLLOWMAKER.progress_ratio >= 0.90 :
		iniciar = false
		BALL.ballDirection = FOLLOWMAKER.position.normalized()

	if not congelado:
		MovimentacaoPlayer()
	if congelado:
		MovimentacaoCongelado()
		
	move_and_slide()


	if Input.is_action_just_pressed("UsarHabilidade") and cooldown.is_stopped():
		habilidadeAtiva = true
		
	if habilidadeAtiva:
		MatchBandeiras(delta)

func MatchBandeiras(delta) -> void:
	
	if not habilidadeAtiva:
		return
	
	match nomeBandeira:#Não comparar objetos, e sim nomes e IDs
		"Alemanha":
			cooldown.start()
			habilidades.bola_energia(BALL, CPU, self)
		"Austria":
			pass
		"Brasil":#PATHMAKER
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, LINHA, self)
		"China":#Terminado
			habilidades.PATHMAKER(BALL, PATHMAKER, LINHA, self)
		"CoreiaSul":#Terminado
			cooldown.start()
			habilidades.DASH(self)
		"HongKong":
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, delta, LINHA)
		"Japao":#BOLA INVISIVEL
			pass
		"Portugal":#Terminado
			habilidades.SALTO(BALL)
			habilidadeAtiva = false
		"Suecia":#Terminado
			cooldown.start()
			habilidades.CONGELAR(CPU, Sound, self)
		"Taiwan":#GRAVIDADE
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
