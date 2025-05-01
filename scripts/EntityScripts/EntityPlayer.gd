extends CharacterBody2D
class_name EntityPlayer


#instancia das classes
@onready var Bandeira = Bandeiras.new()
@onready var habilidades = BandeirasHabilidades.new()

#Export das variaveis para pegar os nós
@export var speed : int 
@export var CPU : CharacterBody2D
@export var Bola : CharacterBody2D

#Variaveis 
var HabilidadeAtiva : bool = false
@onready var spriteTexture = $SpritePlayer
var nomeBandeira : String


func _process(delta: float) -> void:
	MatchBandeiras()

func _physics_process(delta: float) -> void:
	
	MovimentacaoPlayer(delta)
	
	if Input.is_action_just_pressed("UsarHabilidade"):
<<<<<<< main
		$SpritePlayer.texture = Bandeira.Alemanha
		spriteTexture = Bandeira.Alemanha
		HabilidadeAtiva = true
=======
		spriteTexture.texture = Bandeira.Suecia
		$SpritePlayer.texture = Bandeira.Suecia
		nomeBandeira = "Suecia"
>>>>>>> local

		HabilidadeAtiva = true
		
	if HabilidadeAtiva:
		MatchBandeiras()

func MatchBandeiras() -> void:
	
	if not HabilidadeAtiva:
		return
	
	match nomeBandeira:#Não comparar objetos, e sim nomes e IDs
		Bandeira.Alemanha:
			habilidades.Impulse(Bola, self, CPU)
		Bandeira.Austria:
			pass
		Bandeira.Brasil:
			pass
		Bandeira.China:
			pass
		Bandeira.Coreia:
			pass
		Bandeira.HongKong:
			pass
		Bandeira.Japao:
			pass
		Bandeira.Portugal:
			pass
		"Suecia":
			habilidades.Freeze(CPU, self)

func MovimentacaoPlayer(delta : float) -> void:
	var direction = Input.get_axis("up", "down")
	if direction:
		position.y += direction * speed * delta
	position.y = clamp(position.y, 108, 476)#Limitando até onde a posição do player poderá ir
