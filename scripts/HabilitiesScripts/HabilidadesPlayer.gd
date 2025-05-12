extends Node
class_name HabilidadesPlayer

var Cena = preload("res://scenes/EntityScenes/bolinha.tscn")
var colidiu : bool = false


func dash(Player : EntityPlayer):#HABILIADE TERMINADA E TESTADA
	
	if Input.is_action_pressed("down"):
		
		var tween = Player.create_tween()
		var destino = clamp(Player.position.y + 160, 96, 505)
		tween.tween_property(Player, "position:y", destino, 0.15)
		
		Player.HabilidadeAtiva = false
	
	if Input.is_action_pressed("up"):
		
		var tween = Player.create_tween()
		var destino = clamp(Player.position.y - 160, 96, 505)
		tween.tween_property(Player, "position:y", destino, 0.15)
		
		Player.HabilidadeAtiva = false

func clarao(Player : CharacterBody2D) -> void:
	pass
	
func congelar(CPU: EntityCPU, Sound : Sounds) -> void:#Terminado e testado
	
	Sound.PlayFreezeSound()
	
	var CongeladoTween = CPU.create_tween()
	CongeladoTween.tween_property(CPU.SpriteCongelado, "modulate", Color.WHITE, 0.6)
	
	CPU.congelado = true
	await CPU.get_tree().create_timer(3.0).timeout
	
	var DescongeladoTween = CPU.create_tween()
	DescongeladoTween.tween_property(CPU.SpriteCongelado, "modulate", Color.TRANSPARENT, 0.6)
	CPU.congelado = false

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

func salto(Ball : EntityBall) -> void:#Terminado e testado
	
	var newDirection := Vector2()
	newDirection.x = Ball.ballDirection.x
	
	if Ball.ballDirection.y < 0:
		newDirection.y = randf_range(0.7, 0.6)
	else:
		newDirection.y = randf_range(-0.7, -0.6)
	Ball.ballDirection = newDirection.normalized()

func impulso(Ball : EntityBall, Player : EntityPlayer, CPU : EntityCPU) -> void: #TERMINADO E TESTADO
	
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
			colidiu = false

func bolaEnergia(Ball: EntityBall, CPU : EntityCPU) -> void:#Burst de velocidade
	pass

func pathMaker(Ball : EntityBall):
	pass
