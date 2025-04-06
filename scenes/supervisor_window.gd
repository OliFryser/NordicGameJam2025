class_name SuperviserWindow
extends Node2D


@export var sprite : Sprite2D
@export var supervisorIdle : Texture
@export var supervisorScared : Texture
@export var closeButton : Button


signal say(message: String)


func _ready() -> void:
	closeButton.pressed.connect(on_try_close)


func on_try_close():
	set_scared()
	say.emit("Don't do that!")


func set_idle() -> void:
	sprite.texture = supervisorIdle


func set_scared() -> void:
	sprite.texture = supervisorScared
