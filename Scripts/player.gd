extends CharacterBody2D

var speed : int = 250

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	var direction = Input.get_axis("cima", "baixo")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = 0
	move_and_slide()
