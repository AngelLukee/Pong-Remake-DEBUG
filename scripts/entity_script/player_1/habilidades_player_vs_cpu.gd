extends Node
class_name HabilidadesVsCpu

var ball_scene = preload("res://scenes/entity_scenes/bolinha.tscn")
var colidiu : bool = false
var energia : bool = false
var velocidade : bool = false
var iniciado : bool = false


func dash(player : EntityPlayer):#HABILIADE TERMINADA E TESTADA
	
	if Input.is_action_pressed("down"):
		
		var tween = player.create_tween()
		var destino = clamp(player.position.y + 160, 96, 505)
		tween.tween_property(player, "position:y", destino, 0.15)
		
		player.HabilidadeAtiva = false
	
	if Input.is_action_pressed("up"):
		
		var tween = player.create_tween()
		var destino = clamp(player.position.y - 160, 96, 505)
		tween.tween_property(player, "position:y", destino, 0.15)
		
		player.habilidade_ativa = false

func clarao(flash_light : PointLight2D, player : EntityPlayer) -> void:#Falta melhorias na luz
	var tween = player.create_tween()
	tween.tween_property(flash_light, "energy", 15.2, 0.4)
	
	await player.get_tree().create_timer(2.5).timeout
	var tween2 = player.create_tween()
	tween2.tween_property(flash_light, "energy", 0, 0.3)
	player.habilidade_ativa = false
	
func congelar(cpu : EntityCPU, sound : Sounds, player : EntityPlayer) -> void:#Terminado e testado
	sound.PlayFreezeSound()
	
	var congelado_tween = cpu.create_tween()
	congelado_tween.tween_property(cpu.SpriteCongelado, "modulate", Color.WHITE, 0.6)
	
	cpu.congelado = true
	await cpu.get_tree().create_timer(3.0).timeout
	
	var descongelado_tween = cpu.create_tween()
	descongelado_tween.tween_property(cpu.SpriteCongelado, "modulate", Color.TRANSPARENT, 0.6)
	cpu.congelado = false

func clone(ball : EntityBall) -> void:
	
	ball.visible = false
	
	var falseBall : EntityBall = ball_scene.instantiate()
	falseBall.visible = false
	falseBall.global_position = ball.global_position
	falseBall.ballVelocity = ball.ballVelocity
	var newDirection := Vector2()
	falseBall.real = false
	newDirection.x = ball.ballDirection.x
	newDirection.y = ball.ballDirection.y * -1.0
	falseBall.ballDirection = newDirection.normalized()
	
	falseBall.visible = true
	ball.visible = true
	ball.get_parent().add_child(falseBall)

func salto(ball : EntityBall) -> void:#Terminado e testado
	
	var new_direction := Vector2()
	new_direction.x = ball.ballDirection.x
	
	if ball.ballDirection.y < 0:
		new_direction.y = randf_range(0.7, 0.6)
	else:
		new_direction.y = randf_range(-0.7, -0.6)
		
	ball.ballDirection = new_direction.normalized()

func impulso(ball : EntityBall, player : EntityPlayer, cpu : EntityCPU) -> void: #Bug corrigido
	if ball.ballCollision:
		var collider = ball.ballCollision.get_collider()

		if collider == player and not colidiu:
			colidiu = true
			ball.ballVelocity += 150
			var new_direction := Vector2()
	
			new_direction.x = ball.ballDirection.x 
			new_direction.y = [2.0, -2.0].pick_random()
	
			ball.ballDirection = new_direction.normalized()

		if collider == cpu and colidiu:
			ball.ballVelocity -= 150
			colidiu = false
			player.habilidade_ativa = false
			
	if ball.global_position.x > 1200:
			colidiu = false

func bola_energia(ball: EntityBall, cpu : EntityCPU, player : EntityPlayer) -> void:#precisa de sprite

	if not energia:
		ball.ballVelocity += 150
		energia = true
		
	if ball.ballCollision:
		var collider = ball.ballCollision.get_collider()
		if collider == cpu and energia:
			
			if velocidade == false:
				ball.ballVelocity -= 150
				print("VELOCIDADE")
				velocidade = true
				
			cpu.velocidade = 0
			await cpu.get_tree().create_timer(1.0).timeout
			cpu.velocidade = 100
			
			await cpu.get_tree().create_timer(2.5).timeout
			cpu.velocidade = 300
			energia = false
			velocidade = false
			player.habilidade_ativa = false
		
		if collider == player and not energia:
			ball.ballVelocity -= 150
			energia = false
			velocidade = false
			player.habilidade_ativa = false
		
	if ball.global_position.x > 1200:
		velocidade = false
		energia = false

func pathmaker(ball : EntityBall, path2d : Path2D, linha : Line2D, player : EntityPlayer) -> void:#Erro zero lenght
	
	var curve = Curve2D.new()
	var ponto = ball.get_global_mouse_position()
	ponto.x = clamp(ponto.x, 645, 1150)
	ponto.y = clamp(ponto.y, 100, 610)
	
	if not iniciado:
		Engine.time_scale = 0.22
		if Input.is_action_pressed("mouseclick"):
			linha.add_point(ponto)
			if linha.get_point_count() > 200:
				linha.remove_point(0)
			
		await ball.get_tree().create_timer(2.5, true, false, true).timeout
		if linha.points.size() > 1:
			for points in linha.points.size():
				if points % 2 != 0:
					for point in linha.points:
						curve.add_point(point)
		iniciado = true
		
	if iniciado:
		path2d.curve = curve
		Engine.time_scale = 1.00
		player.iniciar = true
		player.habilidadeAtiva = false
		
func rota(ball : EntityBall, path_follow : PathFollow2D, path_2d : Path2D, player_1 : EntityPlayer, delta : float):#Terminado e pronto
	if not iniciado:
		path_2d.RandomPath()
		iniciado = true
	
	var pontos_position = path_2d.curve.point_count
	
	if path_follow.progress_ratio < 1.0:
		path_follow.progress += (ball.ballVelocity - 100) * delta
		ball.global_position = path_follow.global_position
	
	var direcao = path_2d.curve.get_point_position(pontos_position - 1) - path_2d.curve.get_point_position(pontos_position - 2)
	
	if path_follow.progress_ratio >= 0.99:
		ball.ballDirection = direcao.position.normalized()
		iniciado = false
		player_1.habilidade_ativa = false
		
func gravidade(ball : EntityBall, ima_sprite : Sprite2D, player : EntityPlayer):#FEITO E TESTADO, falta sprite
	
	var distancia = ball.global_position.distance_to(ima_sprite.global_position)
	var new_dir : Vector2 = (ima_sprite.global_position - ball.global_position).normalized()
	
	if ball.global_position.y > 356:
		ima_sprite.global_position = Vector2(1222, 606)
		ima_sprite.rotation = -1.0472
		ball.ballDirection = new_dir
		
		if distancia < 150:
			ima_sprite.visible = true
			player.habilidade_ativa = false
			
	if ball.global_position.y < 356:
		ima_sprite.global_position = Vector2(1222, 67)
		ima_sprite.rotation = -2.0944
		ball.ballDirection = new_dir
		
		if distancia < 150:
			ima_sprite.visible = true
			player.habilidadeAtiva = false
