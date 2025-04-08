class_name Draggable
extends Node2D


@export var dragButton: Button
var isDragged: bool
var dragPoint: Vector2


func _ready() -> void:
	dragButton.button_down.connect(
			func (): 
				isDragged = true
				dragPoint = get_viewport().get_mouse_position()
				
	)
	dragButton.button_up.connect(func (): isDragged = false)


func _process(delta: float) -> void:
	if isDragged:
		var newPoint := get_viewport().get_mouse_position()
		var moved := newPoint - dragPoint
		dragPoint = newPoint
		position += moved
