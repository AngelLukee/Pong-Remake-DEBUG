extends CharacterBody2D

@export var speed : int 
#Adicionar 
func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("up", "down")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = 0
	
	move_and_slide() 
