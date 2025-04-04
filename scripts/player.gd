extends CharacterBody2D


@export var speed : int 
@onready var habilidades = Habilidades.new()#Instancia da classe habilidades
var UsarHabilidade : bool = false


func _physics_process(delta: float) -> void:
	print(delta)
	#Movimentação do player
	var direction = Input.get_axis("up", "down")
	if direction and UsarHabilidade == false:
		position.y += direction * speed * delta
	
	#Limitando até onde a posição do player poderá ir
	position.y = clamp(position.y, 108, 495)
	if Input.is_action_just_pressed("ui_accept"):
		UsarHabilidade = true
	if UsarHabilidade == true:
		habilidades.DashHability(self)
