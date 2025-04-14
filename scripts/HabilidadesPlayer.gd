extends Node
class_name Habilidades

var Cena = preload("res://scenes/bolinha.tscn")


func Dash(Player : CharacterBody2D):#Habilidade da coreia do sul
	#Pad se movendo para fora da tela ao chegar na borda e tentar usar habilidade
	if Input.is_action_pressed("down"):
		var tween = Player.create_tween()#Instanciando o create tween do proprio player, pois ele participa do nó
		tween.tween_property(Player, "position:y", Player.position.y + 160, 0.15)
		Player.UsarHabilidade = false
	
		
	if Input.is_action_pressed("up"):
		var tween = Player.create_tween()
		tween.tween_property(Player, "position:y", Player.position.y - 160, 0.15)
		Player.UsarHabilidade = false

func Flash(Player : CharacterBody2D) -> void:
	if Input.is_action_just_pressed("UsarHabilidade"):
		pass
		
func Freeze(Bola : CharacterBody2D, PadAdversario: CharacterBody2D) -> void:
	var velocidade_bola = Bola.velocidade
	var velocidade_pad = PadAdversario.velocidade
	
	Bola.velocidade = 100
	PadAdversario.velocidade = 100
	
	await Bola.get_tree().create_timer(3.5).timeout
	Bola.velocidade = velocidade_bola
	PadAdversario.velocidade = velocidade_pad
	
func Invisible(Bola : Bolinha) -> void:
	
	var BolaSecundaria : Bolinha = Cena.instantiate()
	
	Bola.visible = false
	BolaSecundaria.visible = false
	
	#Direcao da bola está indo errada
	#Sicronizar com a bola verdadeira
	BolaSecundaria.velocidade = Bola.velocidade
	BolaSecundaria.Bola_verdadeira = false
	BolaSecundaria.Colisao.disabled = true
	BolaSecundaria.global_position = Bola.global_position
	BolaSecundaria.direcao = Bola.direcao

	
	await Bola.get_tree().create_timer(0.3).timeout
	Bola.visible = true
	BolaSecundaria.visible = true
	Bola.get_parent().add_child(BolaSecundaria)

func Route(Bola : Bolinha) -> void:
	#Melhorar direção da bola, evitando que ela vá reta
	
	var new_dir := Vector2()
	new_dir.x = Bola.direcao.x 
	
	if Bola.direcao.y < 0.4:
		new_dir.y = Bola.direcao.y * -1.2
	if Bola.Direcao.y > 0.4:
		pass
	Bola.direcao = new_dir.normalized()
	print(Bola.direcao)
	

func Impulse(Bola : Bolinha, Player : player ) -> void: 
	pass
