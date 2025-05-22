extends CharacterBody2D
class_name EntityCPU

#Instancias
@onready var habilidades = HabilidadesCPU.new()

#Exports
@export var Ball : EntityBall
@export var SpriteCongelado : Sprite2D
@export var Sound : Sounds
@export var cooldown : Timer 
@export var PLAYER : EntityPlayer
@export var Imasprite : Sprite2D


#Booleanos
var congelado : bool = false
var habilidadeAtiva : bool = false

#Variaveis
var velocidade : int = 330
var direction : float
var nomeBandeira : String = "Taiwan"

#RNG
var randomNumber = [0,1]

func _ready() -> void:
	if ScriptGlobal.player_script_to_use != null:
		self.set_script(ScriptGlobal.player_script)

func _process(delta: float) -> void:

	global_position.x = clampi(global_position.x, 1178, 1178)
	global_position.y = clampi(global_position.y, 100, 612)


func _physics_process(delta: float) -> void:
	
	if not congelado:
		movimentacaoCPU(delta)
		
	if congelado:
		Congelado()
		
	if Input.is_action_just_pressed("habilidadeCPU") and cooldown.is_stopped():
		habilidadeAtiva = true
		
	
	if habilidadeAtiva: 
		MatchBandeiras()
		
	velocity.y = clampi(velocity.y, -330, 330)
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
			habilidades.CONGELAR(PLAYER, Sound)
			cooldown.start()
			habilidadeAtiva = false
		"China":
			habilidades.IMPULSO(Ball, PLAYER, self)
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
			habilidades.SALTO(Ball)
			habilidadeAtiva = false

func Congelado():
	
	var direction = Ball.global_position.y - global_position.y
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

func _on_detecao_meio_quadra_body_entered(body: Node2D) -> void:
	if not (body is EntityBall):#Comparando com className
		return
		
	if not habilidadeAtiva and cooldown.is_stopped():
		var choice = randomNumber.pick_random()
		match choice:
			0:
				return
			1:
				habilidadeAtiva = true
				cooldown.start()
