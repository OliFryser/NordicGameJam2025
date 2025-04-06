extends Node2D


@export var sprite : Sprite2D
@export var supervisorIdle : Texture
@export var supervisorScared : Texture


func _ready() -> void:
	sprite.texture = supervisorScared
