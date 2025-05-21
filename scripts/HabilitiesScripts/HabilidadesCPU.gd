extends Node
class_name HabilidadesCPU

var colidiu : bool = false
var iniciado : bool = false
var energia : bool = false

func DASH(CPU : EntityCPU):
	
	if CPU.direction < -20:
		var tween = CPU.create_tween()
		var destino = clamp(CPU.position.y - 150, 96, 505)
		tween.tween_property(CPU, "position:y", destino, 0.15)
	

	if CPU.direction > 20:
		var tween = CPU.create_tween()
		var destino = clamp(CPU.position.y + 150, 96, 505)
		tween.tween_property(CPU, "position:y", destino, 0.15)

func CONGELAR(PLAYER : EntityPlayer, SOUND : Sounds):
	SOUND.PlayFreezeSound()
	
	var CongeladoTween = PLAYER.create_tween()
	CongeladoTween.tween_property(PLAYER.SpriteCongelado, "modulate", Color.WHITE, 0.6)
	
	PLAYER.congelado = true
	await PLAYER.get_tree().create_timer(3.0).timeout
	
	var DescongeladoTween = PLAYER.create_tween()
	DescongeladoTween.tween_property(PLAYER.SpriteCongelado, "modulate", Color.TRANSPARENT, 0.6)
	PLAYER.congelado = false
	
func IMPULSO(BALL : EntityBall, PLAYER : EntityPlayer, CPU : EntityCPU):
	if BALL.ballCollision:
		var collider = BALL.ballCollision.get_collider()

		if collider == CPU and not colidiu:
			colidiu = true
			BALL.ballVelocity += 170
			var newDirection := Vector2()
	
			newDirection.x = BALL.ballDirection.x 
			newDirection.y = [2.0, -2.0].pick_random()
	
			BALL.ballDirection = newDirection.normalized()

		if collider == PLAYER and colidiu == true:
			BALL.ballVelocity -= 170
			colidiu = false

			
func ROTA(Ball : EntityBall, pathFollow : PathFollow2D, delta, PATH : Path2D, PLAYER : EntityPlayer):#Terminado e pronto
	if not iniciado:
		PATH.RandomPath()
		iniciado = true
	
	if pathFollow.progress_ratio < 1.0:
		pathFollow.progress += (Ball.ballVelocity - 100) * delta
		Ball.global_position = pathFollow.global_position
	
	if pathFollow.progress_ratio == 1.0:
		Ball.ballDirection = pathFollow.position.normalized()
		PLAYER.habilidadeAtiva = false


func GRAVIDADE(BALL : EntityBall, IMASPRITE : Sprite2D, CPU : EntityCPU):#Testada e funcionando
	var distancia = BALL.global_position.distance_to(IMASPRITE.global_position)
	var NewDir : Vector2 = (IMASPRITE.global_position - BALL.global_position).normalized()
	
	if BALL.global_position.y > 356:
		IMASPRITE.global_position = Vector2(41, 606)
		IMASPRITE.rotation = 1.0472
		BALL.ballDirection = NewDir
		IMASPRITE.visible = true
		if distancia < 150:
			IMASPRITE.visible = false
			CPU.habilidadeAtiva = false
			
	if BALL.global_position.y < 356:
		IMASPRITE.global_position = Vector2(41, 67)
		IMASPRITE.rotation = 2.0944
		BALL.ballDirection = NewDir
		IMASPRITE.visible = true
		if distancia < 150:
			IMASPRITE.visible = false
			CPU.habilidadeAtiva = false

func BOLAENERGIA(Ball: EntityBall, CPU : EntityCPU, PLAYER : EntityPlayer) -> void:#precisa de sprite
	
	if not energia:
		Ball.ballVelocity += 150
		energia = true
		
	if Ball.ballCollision:
		var collider = Ball.ballCollision.get_collider()
		if collider == PLAYER:
			
			Ball.ballVelocity -= 150
			PLAYER.velocidade = 0
			print("Receba")
			await CPU.get_tree().create_timer(0.5).timeout
			PLAYER.velocidade = 150
			
			await CPU.get_tree().create_timer(2.5).timeout
			PLAYER.velocidade = 300
			CPU.habilidadeAtiva = false
func SALTO(Ball : EntityBall) -> void:#Terminado e testado
	
	var newDirection := Vector2()
	newDirection.x = Ball.ballDirection.x
	
	if Ball.ballDirection.y < 0:
		newDirection.y = randf_range(0.7, 0.6)
	else:
		newDirection.y = randf_range(-0.7, -0.6)
	Ball.ballDirection = newDirection.normalized()
