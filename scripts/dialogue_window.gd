class_name DialogueWindow
extends Node2D


@export var label : Label
@export var soundPlayer: AudioStreamPlayer2D
var startPosition: Vector2


func _ready() -> void:
	startPosition = position


func showMessage(message: String):
	label.text = message
	var moveOffset := 100
	var newX := randf_range(-moveOffset, moveOffset)
	var newY := randf_range(-moveOffset, moveOffset)
	position = startPosition + Vector2(newX, newY)
	soundPlayer.play()
