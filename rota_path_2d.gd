extends Path2D

var paths_cpu : Array = [
load("res://Resource/Curve2D_cpu-player2/path_1_cpu.tres"),
load("res://Resource/Curve2D_cpu-player2/path_2_cpu.tres"),
load("res://Resource/Curve2D_cpu-player2/path_3_cpu.tres"),
load("res://Resource/Curve2D_cpu-player2/path_4_cpu.tres"),
load("res://Resource/Curve2D_cpu-player2/path_5_cpu.tres")
]

func random_path_cpu() -> void:
	curve = paths_cpu.pick_random()
