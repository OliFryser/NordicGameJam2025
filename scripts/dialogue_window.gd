class_name DialogueWindow
extends Node2D


@export var label : Label


func showMessage(message: String):
	label.text = message
	var newX := position.x + randf_range(-10, 10)
	var newY := position.y + randf_range(-10, 10)
	position = Vector2(newX, newY)
