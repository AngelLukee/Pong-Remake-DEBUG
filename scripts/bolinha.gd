extends CharacterBody2D

const velocidade_inicial : int = 300
const aceleracao : int = 30

var window_size : Vector2
var velocidade : int = 300
var direcao : Vector2 = Vector2(1,0).normalized()

func _ready() -> void:
	
	window_size = get_viewport_rect().size #Calcula e guarda o tamanho da janela atual

func _physics_process(delta: float):
	
	
	var ball_collision = move_and_collide(direcao * velocidade * delta)#Movimenta a bola e informa caso ela colida
	
	if ball_collision:
		var collider = ball_collision.get_collider()
		if collider == $"../IA" or collider == $"../player":
			random_direction()
			velocidade += 30
		else:
			ball_kick()


func ball_kick():#Requica a bola ao bater nas paredes
	var new_dir : Vector2 
	new_dir.x = direcao.x
	new_dir.y = direcao.y * -1
	direcao = new_dir.normalized()

func random_direction():#Randomiza a direção da bola ao tocar em algum dos tabletes
	var new_dir := Vector2()
	new_dir.x = direcao.x * -1
	new_dir.y = randf_range(-0.4, 1)
	direcao = new_dir.normalized()
	
func random_spawn():
	velocidade = velocidade_inicial
	self.position = window_size / 2
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	direcao = new_dir.normalized()
