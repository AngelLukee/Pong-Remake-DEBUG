extends Node
class_name HabilidadesPlayer

var Cena = preload("res://scenes/EntityScenes/bolinha.tscn")
var colidiu : bool = false
var energia : bool = false
@onready var iniciado : bool = false


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

func CLARAO(POINTLIGHT : PointLight2D, PLAYER : EntityPlayer) -> void:#Falta melhorias na luz
	var tween = PLAYER.create_tween()
	tween.tween_property(POINTLIGHT, "energy", 14.5, 0.4)
	await PLAYER.get_tree().create_timer(2.5).timeout
	var tween2 = PLAYER.create_tween()
	tween2.tween_property(POINTLIGHT, "energy", 0, 0.3)
	PLAYER.habilidadeAtiva = false
	
func CONGELAR(CPU: EntityCPU, Sound : Sounds, PLAYER : EntityPlayer) -> void:#Terminado e testado
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

func IMPULSO(Ball : EntityBall, Player : EntityPlayer, CPU : EntityCPU) -> void: #Bug corrigido
	if Ball.ballCollision:
		var collider = Ball.ballCollision.get_collider()

		if collider == Player and not colidiu:
			colidiu = true
			Ball.ballVelocity += 150
			var newDirection := Vector2()
	
			newDirection.x = Ball.ballDirection.x 
			newDirection.y = [2.0, -2.0].pick_random()
	
			Ball.ballDirection = newDirection.normalized()

		if collider == CPU and colidiu:
			Ball.ballVelocity -= 150
			colidiu = false
			Player.habilidadeAtiva = false
			
	if Ball.global_position.x > 1200:
			colidiu = false

func bola_energia(Ball: EntityBall, CPU : EntityCPU, PLAYER : EntityPlayer) -> void:#precisa de sprite
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

func PATHMAKER(Ball : EntityBall, PATH2D : Path2D, linha : Line2D, PLAYER : EntityPlayer) -> void:
	
	var curve = Curve2D.new()
	var ponto = Ball.get_global_mouse_position()
	ponto.x = clamp(ponto.x, 645, 1150)
	ponto.y = clamp(ponto.y, 100, 610)
	
	if not iniciado:
		Engine.time_scale = 0.22
		if Input.is_action_pressed("mouseclick"):
			linha.add_point(ponto)
			
		await Ball.get_tree().create_timer(2.5, true, false, true).timeout
		for points in linha.points:
			curve.add_point(points)
		iniciado = true
		
	if iniciado:
		PATH2D.curve = curve
		Engine.time_scale = 1.00
		PLAYER.iniciar = true
		PLAYER.habilidadeAtiva = false
		
func ROTA(Ball : EntityBall, pathFollow : PathFollow2D, delta, PATH : Path2D, PLAYER : EntityPlayer):#Feito e pronto
	if not iniciado:
		PATH.RandomPath()
		iniciado = true
	
	if pathFollow.progress_ratio < 1.0:
		pathFollow.progress += (Ball.ballVelocity - 100) * delta
		Ball.global_position = pathFollow.global_position
	
	if pathFollow.progress_ratio == 1.0:
		Ball.ballDirection = pathFollow.position.normalized()
		PLAYER.habilidadeAtiva = false
		
func GRAVIDADE(BALL : EntityBall, IMASPRITE : Sprite2D, PLAYER : EntityPlayer):#FEITO E TESTADO, falta sprite
	var distancia = BALL.global_position.distance_to(IMASPRITE.global_position)
	var NewDir : Vector2 = (IMASPRITE.global_position - BALL.global_position).normalized()
	
	if BALL.global_position.y > 356:
		IMASPRITE.global_position = Vector2(1222, 606)
		IMASPRITE.rotation = -1.0472
		BALL.ballDirection = NewDir
		if distancia < 150:
			IMASPRITE.visible = true
			PLAYER.habilidadeAtiva = false
			
	if BALL.global_position.y < 356:
		IMASPRITE.global_position = Vector2(1222, 67)
		IMASPRITE.rotation = -2.0944
		BALL.ballDirection = NewDir
		if distancia < 150:
			IMASPRITE.visible = true
			PLAYER.habilidadeAtiva = false
