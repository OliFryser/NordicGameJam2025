class_name DialogueWindow
extends Node2D


@export var label : Label
@export var soundPlayer: AudioStreamPlayer2D


func showMessage(message: String):
	label.text = message
	var moveOffset := 100
	var newX := position.x + randf_range(-moveOffset, moveOffset)
	var newY := position.y + randf_range(-moveOffset, moveOffset)
	position = Vector2(newX, newY)
	soundPlayer.play()
