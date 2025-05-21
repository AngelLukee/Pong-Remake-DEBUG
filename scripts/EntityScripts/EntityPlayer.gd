extends CharacterBody2D
class_name EntityPlayer

#instancia das classes e onreadys
@onready var habilidades = HabilidadesPlayer.new()

#onreadys das cenas
@onready var cpu : EntityCPU = $"../CPUBody"
@onready var ball : EntityBall = $"../BolaBody"
@onready var sound : Node = $"../AUDIOS"
@onready var sprite_congelado : Sprite2D = $Freeze
@onready var cooldown : Timer = $cooldown
@onready var rota_path_follow : PathFollow2D = $"../HABILIDADES/rota2d/rotafollow2d"
@onready var rota_path : Path2D = $"../HABILIDADES/rota2d"
@onready var flash_light : PointLight2D = $"../HABILIDADES/flash"
@onready var linha : Line2D = $"../HABILIDADES/linhapathmaker"
@onready var pathmaker_path : Path2D = $"../HABILIDADES/pathmaker2d"
@onready var pathmaker_path_follow : PathFollow2D = $"../HABILIDADES/pathmaker2d/makerfollow2d"
@onready var ima_sprite : Sprite2D = $"../HABILIDADES/IMASPRITE"


#Variaveis 
var habilidade_ativa : bool = false
var nome_bandeira : String = "Alemanha"
var velocidade : int = 300
var player_script = load("res://scripts/EntityScripts/EntityPlayer.gd")

#Booleanos
var congelado : bool = false
var iniciar : bool = false

func _ready() -> void:
	print(cpu)

func _process(delta: float) -> void:
	global_position.x = clampi(global_position.x, 102, 102)
	global_position.y = clampi(global_position.y, 100, 612)
	pass
	
func _physics_process(delta: float) -> void:
	
	match_bandeiras(delta)
	
	if iniciar:
		pathmaker_path_follow.progress += delta * ball.ballVelocity
		ball.global_position = pathmaker_path_follow.global_position
		
	if pathmaker_path_follow.progress_ratio >= 0.90 :
		iniciar = false
		ball.ballDirection = pathmaker_path_follow.position.normalized()


	if not congelado:
		movimentacao_player()
	else:
		movimentacao_congelado()
		
	move_and_slide()


	if Input.is_action_just_pressed("UsarHabilidade") and cooldown.is_stopped():
		habilidade_ativa = true
		
	if habilidade_ativa:
		match_bandeiras(delta)

func match_bandeiras(delta) -> void:
	
	if not habilidade_ativa:
		return
	
	match nome_bandeira:#Não comparar objetos, e sim nomes e IDs
		"Alemanha":
			cooldown.start()
			habilidades.bola_energia(ball, cpu, self)
		"Austria":
			pass
		"Brasil":#PATHMAKER
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, LINHA, self)
		"China":#Terminado
			cooldown.start()
			habilidades.CLARAO(flash_light, self)
		"CoreiaSul":#Terminado
			cooldown.start()
			habilidades.DASH(self)
		"HongKong":
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, delta, LINHA)
		"Japao":#BOLA INVISIVEL
			pass
		"Portugal":#Terminado
			cooldown.start()
			habilidades.SALTO(ball)
			habilidade_ativa = false
		"Suecia":#Terminado
			cooldown.start()
			habilidades.CONGELAR(cpu, sound, self)
		"Taiwan":#Terminado
			cooldown.start()
			habilidades.GRAVIDADE(ball, ima_sprite, self)

func movimentacao_player():
	var direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 1)
	else:
		velocity.y = 0

func movimentacao_congelado():
	var direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 0.025)
	else:
		velocity.y = lerp(velocity.y, 0.0, 0.009)
		
		if velocity.y < 20 and velocity.y > -20:
			velocity.y = 0
