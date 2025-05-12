extends Node
class_name Sounds

var freezeSound = [
	load("res://Audios/Freeze/Audio1.mp3"),
	load("res://Audios/Freeze/Audio2.mp3"),
	load("res://Audios/Freeze/Audio3.mp3"),
	load("res://Audios/Freeze/Audio4.mp3")
]

@export var Freeze : AudioStreamPlayer 

func PlayFreezeSound():
	Freeze.stream = freezeSound.pick_random()
	Freeze.play()
