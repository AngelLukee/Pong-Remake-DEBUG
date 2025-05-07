extends Node
class_name BandeirasHabilidades

var Cena = preload("res://scenes/bolinha.tscn")
var colidiu : bool = false


func dash(Player : EntityPlayer):#Habilidade da coreia do sul
	
	#Pad se movendo para fora da tela ao chegar na borda e tentar usar habilidade
	
	if Input.is_action_pressed("down"):
		
		var tween = Player.create_tween()
		tween.tween_property(Player, "position:y", Player.position.y + 160, 0.15)
		
		Player.HabilidadeAtiva = false
	
	if Input.is_action_pressed("up"):
		
		var tween = Player.create_tween()
		tween.tween_property(Player, "position:y", Player.position.y - 160, 0.15)
		
		Player.HabilidadeAtiva = false

func clarao(Player : CharacterBody2D) -> void:
	pass

func congelar(CPU: EntityCPU, Player : EntityPlayer) -> void:
	CPU.congelado = true
	await CPU.get_tree().create_timer(3.0).timeout
	CPU.congelado = false
	Player.HabilidadeAtiva = false

	
func clone(Ball : EntityBall) -> void:
	
	Ball.visible = false
	
	var falseBall : EntityBall = Cena.instantiate()
	var newDirection := Vector2()
	falseBall.real = false
	falseBall.global_position.y =  Ball.window.y  - Ball.global_position.y 
	falseBall.global_position.x = Ball.global_position.x
	newDirection.x = Ball.ballDirection.x
	newDirection.y = Ball.ballDirection.y * -1.0
	
	falseBall.ballDirection = newDirection.normalized()
	falseBall.ballVelocity = Ball.ballVelocity
	
	Ball.visible = true
	Ball.get_parent().add_child(falseBall)
	

func Salto(Ball : EntityBall) -> void:#Terminado e testado
	#Melhorar direção da bola, evitando que ela vá reta
	
	var newDirection := Vector2()
	newDirection.x = Ball.ballDirection.x
	
	if Ball.ballDirection.y < 0:
		newDirection.y = randf_range(0.7, 0.6)
	else:
		newDirection.y = randf_range(-0.7, -0.6)
	Ball.ballDirection = newDirection.normalized()
	
	
func Impulso(Ball : EntityBall, Player : EntityPlayer, CPU : EntityCPU) -> void: #TERMINADO E TESTADO
	
	if Ball.ballCollision:
		var collider = Ball.ballCollision.get_collider()

		if collider == Player and not colidiu:
			colidiu = true
			Ball.ballVelocity += 150
			var newDirection := Vector2()
	
			newDirection.x = Ball.ballDirection.x 
			newDirection.y = [2.0, -2.0].pick_random()
	
			Ball.ballDirection = newDirection.normalized()

		if collider == CPU and colidiu == true:
			Ball.ballVelocity -= 150
			Player.HabilidadeAtiva = false
			colidiu = false

func bolaEnergia(Ball: EntityBall, CPU : EntityCPU) -> void:
	pass
