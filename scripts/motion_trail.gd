extends Line2D

func _process(delta: float) -> void:
	var bola_pos = get_parent().global_position
	add_point(bola_pos)

	if points.size() > 30:
		remove_point(0)
