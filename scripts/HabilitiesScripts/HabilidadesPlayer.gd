extends Node
class_name HabilidadesPlayer

var Cena = preload("res://scenes/EntityScenes/bolinha.tscn")
var colidiu : bool = false
var energia : bool = false
var iniciado : bool = false


func DASH(Player : EntityPlayer):#HABILIADE TERMINADA E TESTADA
	
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

func CLARAO(POINTLIGHT : PointLight2D, PLAYER : EntityPlayer) -> void:
	var tween = PLAYER.create_tween()
	tween.tween_property(POINTLIGHT, "energy", 30.0, 0.4)
	await PLAYER.get_tree().create_timer(2.5).timeout
	var tween2 = PLAYER.create_tween()
	tween2.tween_property(POINTLIGHT, "energy", 0, 0.3)
	PLAYER.habilidadeAtiva = false
	
func CONGELAR(CPU: EntityCPU, Sound : Sounds) -> void:#Terminado e testado
	Sound.PlayFreezeSound()
	
	var CongeladoTween = CPU.create_tween()
	CongeladoTween.tween_property(CPU.SpriteCongelado, "modulate", Color.WHITE, 0.6)
	
	CPU.congelado = true
	await CPU.get_tree().create_timer(3.0).timeout
	
	var DescongeladoTween = CPU.create_tween()
	DescongeladoTween.tween_property(CPU.SpriteCongelado, "modulate", Color.TRANSPARENT, 0.6)
	CPU.congelado = false

func CLONE(Ball : EntityBall) -> void:
	
	Ball.visible = false
	
	var falseBall : EntityBall = Cena.instantiate()
	falseBall.visible = false
	falseBall.global_position = Ball.global_position
	falseBall.ballVelocity = Ball.ballVelocity
	var newDirection := Vector2()
	falseBall.real = false
	newDirection.x = Ball.ballDirection.x
	newDirection.y = Ball.ballDirection.y * -1.0
	falseBall.ballDirection = newDirection.normalized()
	
	falseBall.visible = true
	Ball.visible = true
	Ball.get_parent().add_child(falseBall)

func SALTO(Ball : EntityBall) -> void:#Terminado e testado
	
	var newDirection := Vector2()
	newDirection.x = Ball.ballDirection.x
	
	if Ball.ballDirection.y < 0:
		newDirection.y = randf_range(0.7, 0.6)
	else:
		newDirection.y = randf_range(-0.7, -0.6)
	Ball.ballDirection = newDirection.normalized()

func IMPULSO(Ball : EntityBall, Player : EntityPlayer, CPU : EntityCPU) -> void: #TERMINADO E TESTADO
	
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
			Player.habilidadeAtiva = false
			Ball.ballVelocity -= 150
			colidiu = false

func bola_energia(Ball: EntityBall, CPU : EntityCPU, PLAYER : EntityPlayer) -> void:#Precisa de animação e melhoria
	if not energia:
		Ball.ballVelocity += 150
		energia = true
		
	if Ball.ballCollision:
		var collider = Ball.ballCollision.get_collider()
		if collider == CPU:
			
			Ball.ballVelocity -= 150
			CPU.velocidade = 0
			
			await CPU.get_tree().create_timer(0.5).timeout
			CPU.velocidade = 150
			
			await CPU.get_tree().create_timer(2.5).timeout
			CPU.velocidade = 300
			PLAYER.habilidadeAtiva = false

func PATHMAKER(Ball : EntityBall):
	pass

func ROTA(Ball : EntityBall, pathFollow : PathFollow2D, delta, PATH : Path2D, PLAYER : EntityPlayer):
	if not iniciado:
		PATH.RandomPath()
		iniciado = true
	
	if pathFollow.progress_ratio < 1.0:
		pathFollow.progress += (Ball.ballVelocity - 100) * delta
		Ball.global_position = pathFollow.global_position
	
	if pathFollow.progress_ratio == 1.0:
		Ball.ballDirection = pathFollow.position.normalized()
		PLAYER.habilidadeAtiva = false
	
