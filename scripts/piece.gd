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
	if (sprite2D.scale.x < 0.1):
		sprite2D.scale *= size 
	_set_clickable_area_size(area_size)


func _set_clickable_area_size(area_size: int):
	button.position -= Vector2(area_size * .5, area_size * .5)
	button.size = Vector2(area_size, area_size)
	

func display_selection():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite2D, "modulate", Color(2, 2, 2), .05)\
			.set_ease(Tween.EASE_OUT)
	
	
func hide_selection():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite2D, "modulate", Color.WHITE, .05)\
			.set_ease(Tween.EASE_OUT)


func disappear():
	queue_free()


func update_swap_position(position: Vector2, tween: Tween):
	tween.tween_property(self, "position", position, .2)\
			.from_current()


func update_position(position: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", position, randf_range(.8,1.5))\
			.from_current()\
			.set_trans(Tween.TRANS_BOUNCE)\
			.set_ease(Tween.EASE_OUT)


func _on_button_button_down() -> void:
	clicked.emit(self)
