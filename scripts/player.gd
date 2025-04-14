extends CharacterBody2D
class_name player

@export var speed : int 
@onready var habilidades = Habilidades.new()#Instancia da classe habilidades
@export var Adversario : CharacterBody2D
@export var Bola : CharacterBody2D
var ImpulseOn : bool = false


func _physics_process(delta: float) -> void:
	#Movimentação do player
	var direction = Input.get_axis("up", "down")
	if direction:
		position.y += direction * speed * delta
	
	#Limitando até onde a posição do player poderá ir
	position.y = clamp(position.y, 108, 495)
	if Input.is_action_just_pressed("ui_accept"):
		ImpulseOn = true
		habilidades.Impulse(Bola, self)
