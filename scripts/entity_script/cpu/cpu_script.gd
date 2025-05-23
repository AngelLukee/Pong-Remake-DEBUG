extends CharacterBody2D
class_name EntityCPU

#Instancias
@onready var habilidades_cpu = HabilidadesCPU.new()

#exports das entidades
@export var ball : EntityBall 
@export var player_1 : EntityPlayer

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

#Booleanos
var congelado : bool = false
var habilidade_ativa : bool = false

#Variaveis
var velocidade : int = 330
var direction : float
var nome_bandeira : String = "Taiwan"

#RNG
var random_number = [0,1]

func _ready() -> void:
	pass

func _process(delta: float) -> void:

	global_position.x = clampi(global_position.x, 1178, 1178)
	global_position.y = clampi(global_position.y, 100, 612)


func _physics_process(delta: float) -> void:
	
	if not congelado:
		movimentacaoCPU(delta)
		
	if congelado:
		Congelado()
		
	if habilidade_ativa: 
		MatchBandeiras()
		
	velocity.y = clampi(velocity.y, -330, 330)
	move_and_slide()

func MatchBandeiras() -> void:
	
	if not habilidade_ativa:
		return
	
	match nome_bandeira:#Não comparar objetos, e sim nomes e IDs
		"Alemanha":
			pass
		"Austria":
			pass
		"Brasil":
			#habilidades
			cooldown.start()
		"China":
			#habilidades.IMPULSO(Ball, PLAYER, self)
			cooldown.start()
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
		"Taiwan":
			cooldown.start()
			#habilidades.SALTO(ball)
			#habilidadeAtiva = false

func Congelado():
	
	#var direction = Ball.global_position.y - global_position.y
	if abs(direction) > 4:
		velocity.y = lerp(velocity.y, direction * velocidade, 0.025)
	else:
		velocity.y = lerp(velocity.y, 0.0, 0.009)
		
		if velocity.y < 20 and velocity.y > -20:
			velocity.y = 0
			
func movimentacaoCPU(delta):
	
	#var direction = ((Ball.global_position.y + sprite_height.scale.y / 2) - global_position.y)
	#velocity.y = direction * velocidade * delta
	var direction = Input.get_axis("otherup", "otherdowm")
	if direction:
		velocity.y = lerp(velocity.y, direction * velocidade, 1)
	else:
		velocity.y = 0

#func _on_detecao_meio_quadra_body_entered(body: Node2D) -> void:
	#if not (body is EntityBall):#Comparando com className
	#	return
		
	#if not habilidadeAtiva and cooldown.is_stopped():
	#	var choice = randomNumber.pick_random()
	#	match choice:
	#		0:
	#			return
	#		1:
	#			habilidadeAtiva = true
	#			cooldown.start()
