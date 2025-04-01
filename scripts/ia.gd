extends CharacterBody2D


@export var speed : int 

func _physics_process(delta: float) -> void:

	var direction = Input.get_axis("otherup", "otherdowm")
	if direction:
		position.y += direction * speed * delta
	
	position.y = clampi(position.y, 108, 495)
