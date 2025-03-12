extends CharacterBody2D

const velocidade_inicial : int = 300
const aceleracao : int = 30

var window_size : Vector2
var velocidade : int = 300
var direcao : Vector2 = Vector2(1,0).normalized()

func _ready() -> void:
	
	window_size = get_viewport_rect().size #Calcula e guarda o tamanho da janela atual

func new_position():
	position.x = window_size.x / 2 #Inicia no centro da janela

	
func _physics_process(delta: float):
	
	var ball_collision = move_and_collide(direcao * velocidade * delta)#Movimenta a bola e informa caso ela colida
	if ball_collision:
		var collider = ball_collision.get_collider()
		if collider == $"../IA":
			direcao = Vector2(-1, 0)
			velocidade += 30
		if collider == $"../player":
			random_direction()
			velocidade += 30
	
	
	
	
func random_direction():
	var new_dir := Vector2()
	new_dir.x = randf_range(0.1, 1.0)
	new_dir.y = randf_range(-0.3, 0.3)
	direcao = new_dir.normalized()
	
