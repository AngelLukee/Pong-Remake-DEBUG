extends Button

func _on_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($"../Background", color, Color.BLUE, 1.6)
