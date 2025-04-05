class_name Piece
extends Node2D


@export var sprite2D : Sprite2D
@export var collisionShape : CollisionShape2D


signal clicked(piece: Piece)


func set_texture(texture: Texture):
	sprite2D.texture = texture
	var size := sprite2D.texture.get_size()
	sprite2D.scale /= size


func set_size(size : int, area_size: int):
	sprite2D.scale *= size
	_set_clickable_area_size(area_size)


func _set_clickable_area_size(area_size: int):
	collisionShape.scale *= area_size
	

func display_selection():
	
	
	
func hide_selection():
	
	
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton 
			and event.pressed 
			and event.button_index == MOUSE_BUTTON_LEFT
	):
		clicked.emit(self)
