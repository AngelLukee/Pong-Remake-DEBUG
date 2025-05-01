extends Node
class_name BandeirasHabilidades

var Cena = preload("res://scenes/bolinha.tscn")
var colidiu : bool = false

func Dash(Player : EntityPlayer):#Habilidade da coreia do sul
	
	#Pad se movendo para fora da tela ao chegar na borda e tentar usar habilidade
	
	if Input.is_action_pressed("down"):
		
		var tween = Player.create_tween()
		tween.tween_property(Player, "position:y", Player.position.y + 160, 0.15)
		
		Player.HabilidadeAtiva = false
	
	if Input.is_action_pressed("up"):
		
		var tween = Player.create_tween()
		tween.tween_property(Player, "position:y", Player.position.y - 160, 0.15)
		
		Player.HabilidadeAtiva = false

func Flash(Player : CharacterBody2D) -> void:
	pass

<<<<<<< main

func Freeze(Bola : EntityBall, PadAdversario: CharacterBody2D) -> void:
	var velocidade_bola = Bola.velocidade
	var velocidade_pad = PadAdversario.velocidade
	
	Bola.velocidade = 100
	PadAdversario.velocidade = 100
	
	await Bola.get_tree().create_timer(3.5).timeout
	Bola.velocidade = velocidade_bola
	PadAdversario.velocidade = velocidade_pad
=======
func Freeze(CPU: EntityCPU, Player : EntityPlayer) -> void:
	CPU.congelado = true
	await CPU.get_tree().create_timer(3.0).timeout
	CPU.velocity.x = 0
	CPU.congelado = false
	Player.HabilidadeAtiva = false
>>>>>>> local
	
func Invisible(Ball : EntityBall) -> void:
	pass
func Route(Ball : EntityBall) -> void:
	pass
	#Melhorar direção da bola, evitando que ela vá reta
	
	#var new_dir := Vector2()
	#new_dir.x = Bola.direcao.x 
	
	#if Bola.direcao.y < 0.4:
	#	new_dir.y = Bola.direcao.y * -1.2
	#if Bola.Direcao.y > 0.4:
	#	pass
	#Bola.direcao = new_dir.normalized()
	#print(Bola.direcao)
	
func Impulse(Ball : EntityBall, Player : EntityPlayer, CPU : EntityCPU) -> void: 
	
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
