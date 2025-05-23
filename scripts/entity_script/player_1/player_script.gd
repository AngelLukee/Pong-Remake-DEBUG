extends CharacterBody2D
class_name EntityPlayer

#instancia das classes e onreadys
@onready var habilidades_vs_cpu = HabilidadesVsCpu.new()
@onready var habilidades_vs_player2 = HabilidadesVsPlayer2.new()

#exports das entidades
@export var cpu : EntityCPU 
@export var ball : EntityBall 
@export var player_2 : Player2

#exports das cenas de habilidades
@export var sound : Node 
@export var sprite_congelado : Sprite2D 
@export var cooldown : Timer 
@export var rota_path_follow : PathFollow2D 
@export var rota_path : Path2D
@export var flash_light : PointLight2D
@export var linha : Line2D 
@export var pathmaker_path : Path2D
@export var pathmaker_path_follow : PathFollow2D 
@export var ima_sprite : Sprite2D 

#Variaveis 
var habilidade_ativa : bool = false
var nome_bandeira : String = "Alemanha"
var velocidade : int = 300
var player_script = load("res://scripts/EntityScripts/EntityPlayer.gd")

#Booleanos
var congelado : bool = false
var iniciar : bool = false
var vs_player_2 : bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	global_position.x = clampi(global_position.x, 102, 102)
	global_position.y = clampi(global_position.y, 100, 612)
	
	
func _physics_process(delta: float) -> void:
	
	if not congelado:
		movimentacao_player()
	else:
		movimentacao_congelado()
		
	move_and_slide()


	if Input.is_action_just_pressed("UsarHabilidade") and cooldown.is_stopped():
		habilidade_ativa = true
		
	if habilidade_ativa and not vs_player_2:
		match_bandeiras_vs_cpu(delta)
		
	if habilidade_ativa and vs_player_2:
		match_bandeiras_vs_player2(delta)

func match_bandeiras_vs_cpu(delta) -> void:
	if not habilidade_ativa:
		return
	
	match nome_bandeira:
		"Alemanha":
			cooldown.start()
			habilidades_vs_cpu.bola_energia(ball, cpu, self)
		"Austria":
			pass
		"Brasil":#PATHMAKER
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, LINHA, self)
		"China":#Terminado
			cooldown.start()
			habilidades_vs_cpu.clarao(flash_light, self)
		"CoreiaSul":#Terminado
			cooldown.start()
			habilidades_vs_cpu.dash(self)
		"HongKong":
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, delta, LINHA)
		"Japao":#BOLA INVISIVEL
			pass
		"Portugal":
			cooldown.start()
			habilidades_vs_cpu.salto(ball, self)
		"Suecia":#Terminado
			cooldown.start()
			habilidades_vs_cpu.congelar(cpu, sound, self)
		"Taiwan":#Terminado
			cooldown.start()
			habilidades_vs_cpu.gravidade(ball, ima_sprite, self)
			
func match_bandeiras_vs_player2(delta) -> void:
	if not habilidade_ativa:
		return
	
	match nome_bandeira:#Não comparar objetos, e sim nomes e IDs
		"Alemanha":
			cooldown.start()
			habilidades_vs_player2.bola_energia(ball, player_2, self)
		"Austria":
			pass
		"Brasil":#PATHMAKER
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, LINHA, self)
		"China":
			cooldown.start()
			habilidades_vs_player2.clarao(flash_light, self)
		"CoreiaSul":#Terminado
			cooldown.start()
			habilidades_vs_player2.dash(self)
		"HongKong":
			cooldown.start()
			#habilidades.PATHMAKER(BALL, PATHMAKER, FOLLOWMAKER, delta, LINHA)
		"Japao":#BOLA INVISIVEL
			pass
		"Portugal":#Terminado
			cooldown.start()
			habilidades_vs_player2.salto(ball)
			habilidade_ativa = false
		"Suecia":
			cooldown.start()
			habilidades_vs_player2.congelar(player_2, sound, self)
		"Taiwan":#Terminado
			cooldown.start()
			habilidades_vs_player2.gravidade(ball, ima_sprite, self)

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
