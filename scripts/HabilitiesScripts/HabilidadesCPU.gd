extends Node
class_name HabilidadesCPU

var colidiu : bool = false


func DASH(CPU : EntityCPU):#Por enquanto, sem resolução
	
	if CPU.direction < -20:
		var tween = CPU.create_tween()
		var destino = clamp(CPU.position.y - 110, 96, 505)
		tween.tween_property(CPU, "position:y", destino, 0.15)
	

	if CPU.direction > 20:
		var tween = CPU.create_tween()
		var destino = clamp(CPU.position.y + 110, 96, 505)
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
