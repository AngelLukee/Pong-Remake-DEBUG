extends Path2D
class_name preloadPATHINGS


var PATHS : Array = [
load("res://Resource/Curve2D/PATH1.tres"),
load("res://Resource/Curve2D/PATH2.tres"),
load("res://Resource/Curve2D/PATH3.tres"),
load("res://Resource/Curve2D/PATH4.tres"),
load("res://Resource/Curve2D/PATH5.tres")
]


func RandomPath() -> void:
	curve = PATHS.pick_random()
	scale = Vector2(0.737, 1.089)
	if curve in [PATHS[4], PATHS[3], PATHS[0]]:
		global_position = Vector2(360, 375)
	if curve == PATHS[2]:
		global_position = Vector2(276, 375)
	if curve == PATHS[1]:
		global_position = Vector2(444, 366)
		
func RandomPathCPU() -> void:
	curve = PATHS.pick_random()
	scale = Vector2(-0.737, -1.089)
	if curve == PATHS[0]:
		global_position = Vector2(920, 449)
	if curve == PATHS[1]:
		global_position = Vector2(849, 397)
	
