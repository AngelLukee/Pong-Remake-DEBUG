extends CharacterBody2D
class_name EntityBall
#Criando classe, para na classe habilidades, a instancia herdar as caracteristicas daqui

#Constantes
const velocidadeInicial : int = 300
const aceleracao : int = 35

#Exports
@export var CPU : CharacterBody2D
@export var PLAYER : CharacterBody2D
@export var Colisao : CollisionShape2D
@export var areaMeio : Area2D
@export var motionTrail : Line2D

var ballVelocity : int 
var ballDirection : Vector2 = Vector2(1,0).normalized()
var ballCollision
var real : bool = true


func _ready() -> void:
	if real:
		randomSpawn()

func _physics_process(delta: float):
	#Movimenta a bola e informa caso ela colida
	ballCollision = move_and_collide(ballDirection * ballVelocity * delta)

	if ballCollision:
		var collider = ballCollision.get_collider()

		if collider == CPU or collider == PLAYER:
			
			randomDirection()
			ballVelocity += 30
			
			if collider == CPU:
				areaMeio.monitoring = true
				
			elif collider == PLAYER:
				areaMeio.monitoring = false
		else:
			ballKick()


func ballKick():#Requica a bola ao bater nas paredes
	var newDirection : Vector2 
	
	newDirection.x = ballDirection.x
	newDirection.y = ballDirection.y * -1
	
	ballDirection = newDirection.normalized()

func randomDirection():#Randomiza a direção da bola ao tocar em algum dos tabletes
	var newDirection := Vector2()
	
	newDirection.x = ballDirection.x * -1
	newDirection.y = randf_range(-0.4, 0.4)
	print(newDirection)
	ballDirection = newDirection.normalized()
	
func randomSpawn():#Randomiza o spawn da bola se fizerem algum ponto
	
	areaMeio.monitoring = false
	
	var window = get_viewport_rect().size
	self.global_position = window/2
	ballVelocity = velocidadeInicial
	
	
	var newDirection := Vector2()
	newDirection.x = [1, -1].pick_random()
	newDirection.y = randf_range(-0.3, 0.3)
	ballDirection = newDirection.normalized()

func motiontrail():
	pass 
