class_name Piece
extends Node2D


@export var sprite2D : Sprite2D
@export var button : Button


signal clicked(piece: Piece)


func set_texture(texture: Texture):
	sprite2D.texture = texture
	var size := sprite2D.texture.get_size()
	sprite2D.scale /= size


func set_size(size : int, area_size: int):
	sprite2D.scale *= size
	_set_clickable_area_size(area_size)


func _set_clickable_area_size(area_size: int):
	button.position -= Vector2(area_size * .5, area_size * .5)
	button.size = Vector2(area_size, area_size)
	

func display_selection():
	var tween = get_tree().create_tween()
	tween\
			.tween_property(sprite2D, "modulate", Color.WHITE, 1)\
			.set_ease(Tween.EASE_IN)
	
	
func hide_selection():
	var tween = get_tree().create_tween()
	tween\
			.tween_property(sprite2D, "modulate", Color.WHITE, 0)\
			.set_ease(Tween.EASE_IN)


func _on_button_button_down() -> void:
	clicked.emit(self)
