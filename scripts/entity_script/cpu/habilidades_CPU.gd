extends Node
class_name HabilidadesCPU

var colidiu : bool = false
var iniciado : bool = false
var energia : bool = false

func dash(cpu : EntityCPU):
	
	if cpu.direction < -20:
		var tween = cpu.create_tween()
		var destino = clamp(cpu.position.y - 150, 96, 505)
		tween.tween_property(cpu, "position:y", destino, 0.15)
	

	if cpu.direction > 20:
		var tween = cpu.create_tween()
		var destino = clamp(cpu.position.y + 150, 96, 505)
		tween.tween_property(cpu, "position:y", destino, 0.15)

func congelar(player : EntityPlayer, sound : Sounds):
	sound.PlayFreezeSound()
	
	var congelado_tween = player.create_tween()
	congelado_tween.tween_property(player.sprite_Congelado, "modulate", Color.WHITE, 0.6)
	
	player.congelado = true
	await player.get_tree().create_timer(3.0).timeout
	
	var descongelado_tween = player.create_tween()
	descongelado_tween.tween_property(player.SpriteCongelado, "modulate", Color.TRANSPARENT, 0.6)
	player.congelado = false
	
func impulso(ball : EntityBall, player : EntityPlayer, cpu : EntityCPU):
	if ball.ballCollision:
		var collider = ball.ballCollision.get_collider()

		if collider == player and not colidiu:
			colidiu = true
			ball.ballVelocity += 170
			var new_direction := Vector2()
	
			new_direction.x = ball.ballDirection.x 
			new_direction.y = [2.0, -2.0].pick_random()
	
			ball.ballDirection = new_direction.normalized()

		if collider == cpu and colidiu == true:
			ball.ballVelocity -= 170
			colidiu = false

			
func rota(ball : EntityBall, path_follow : PathFollow2D, path_2d : Path2D, cpu : EntityCPU, delta : float):#Terminado e pronto
	if not iniciado:
		path_2d.random_path_cpu()
		iniciado = true
	
	var pontos_position = path_2d.curve.point_count
	
	if path_follow.progress_ratio < 1.0:
		path_follow.progress += (ball.ballVelocity - 100) * delta
		ball.global_position = path_follow.global_position
	
	var direcao = path_2d.curve.get_point_position(pontos_position - 1) - path_2d.curve.get_point_position(pontos_position - 2)
	
	if path_follow.progress_ratio >= 0.95:
		ball.ballDirection = direcao.normalized()
		cpu.habilidade_ativa = false

func gravidade(ball : EntityBall, ima_sprite : Sprite2D, cpu : EntityCPU):#Testada e funcionando
	
	var distancia = ball.global_position.distance_to(ima_sprite.global_position)
	var new_dir : Vector2 = (ima_sprite.global_position - ball.global_position).normalized()
	
	if ball.global_position.y > 356:
		ima_sprite.global_position = Vector2(41, 606)
		ima_sprite.rotation = 1.0472
		ball.ballDirection = new_dir
		ima_sprite.visible = true
		if distancia < 150:
			ima_sprite.visible = false
			cpu.habilidade_ativa = false
			
	if ball.global_position.y < 356:
		ima_sprite.global_position = Vector2(41, 67)
		ima_sprite.rotation = 2.0944
		ball.ballDirection = new_dir
		ima_sprite.visible = true
		if distancia < 150:
			ima_sprite.visible = false
			cpu.habilidade_ativa = false

func bola_energia(ball: EntityBall, cpu : EntityCPU, player : EntityPlayer) -> void:#precisa de sprite
	
	if not energia:
		ball.ballVelocity += 150
		energia = true
		
	if ball.ballCollision:
		var collider = ball.ballCollision.get_collider()
		if collider == player:
			
			ball.ballVelocity -= 150
			player.velocidade = 0
			await cpu.get_tree().create_timer(0.5).timeout
			player.velocidade = 150
			
			await cpu.get_tree().create_timer(2.5).timeout
			player.velocidade = 300
			cpu.habilidade_ativa = false
			
		if ball.global_position.x > 1200 or ball.global_position.x < 30:
			energia = false
			
func salto(ball : EntityBall) -> void:#Terminado e testado
	
	var new_direction := Vector2()
	new_direction.x = ball.ballDirection.x
	
	if Ball.ballDirection.y < 0:
		newDirection.y = randf_range(0.7, 0.6)
	else:
		newDirection.y = randf_range(-0.7, -0.6)
	Ball.ballDirection = newDirection.normalized()
