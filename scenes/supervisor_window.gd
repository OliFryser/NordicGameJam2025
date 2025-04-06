class_name SuperviserWindow
extends Node2D


@export var sprite : Sprite2D
@export var supervisorIdle : Texture
@export var supervisorScared : Texture
@export var closeButton : Button
@export var pointResponses : Array[String]
@export var levelCompleteResponses: Array[String]


signal say(message: String)


func _ready() -> void:
	closeButton.pressed.connect(on_try_close)


func on_try_close():
	set_scared()
	say.emit("Employee: insubordination will not be tolerated. You must sort. If you do not sort, you will be a threat to Safety. Please resume your sorting!")


func set_idle() -> void:
	sprite.texture = supervisorIdle


func set_scared() -> void:
	sprite.texture = supervisorScared


func start_point_response(reward: int) -> void:
	pass

func start_level_completion_response(level: int) -> void:
	if level < levelCompleteResponses.size():
		say.emit(levelCompleteResponses[level])
