extends CharacterBody2D
class_name EntityPlayer


#instancia das classes
@onready var sprite_texture : CompressedTexture2D = $SpritePlayer.texture
@onready var Bandeira = Bandeiras.new()
@onready var habilidades = BandeirasHabilidades.new()

@export var speed : int 
@export var Adversario : CharacterBody2D
@export var Bola : CharacterBody2D


var HabilidadeAtiva : bool = false

func _physics_process(delta: float) -> void:
	#Movimentação do player
	var direction = Input.get_axis("up", "down")
	if direction:
		position.y += direction * speed * delta
	position.y = clamp(position.y, 108, 495)#Limitando até onde a posição do player poderá ir
	

	
	if Input.is_action_just_pressed("UsarHabilidade"):
		HabilidadeAtiva = true
	
	
	match sprite_texture:
		Bandeira.Coreia:
			if HabilidadeAtiva == true:
				habilidades.Dash(self)
				
		Bandeira.Brasil:
			print("Brasil")
