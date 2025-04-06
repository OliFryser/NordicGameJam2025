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
	tween.tween_property(sprite2D, "modulate", Color(2, 2, 2), .05)\
			.set_ease(Tween.EASE_OUT)
	
	
func hide_selection():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite2D, "modulate", Color.WHITE, .05)\
			.set_ease(Tween.EASE_OUT)


func disappear(tween: Tween):
	tween.tween_property(sprite2D, "scale", sprite2D.scale * 2, .1)\
			.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite2D, "modulate", Color(2, 2, 2), .1)\
			.set_ease(tween.EASE_IN_OUT)
	tween.tween_property(sprite2D, "modulate", Color(2, 2, 2, 0), .3)\
			.set_ease(Tween.EASE_OUT)\
			.set_delay(.1)
	tween.tween_property(sprite2D, "scale", Vector2(0,0), .3)\
			.set_ease(Tween.EASE_OUT).set_delay(.1)


func update_swap_position(position: Vector2, tween: Tween):
	tween.tween_property(self, "position", position, .2)\
			.from_current()


func update_position(position: Vector2, tween : Tween):
	#var tween = create_tween()
	tween.tween_property(self, "position", position, randf_range(1,1.5))\
			.from_current()\
			.set_trans(Tween.TRANS_BOUNCE)\
			.set_ease(Tween.EASE_OUT)


func _on_button_button_down() -> void:
	clicked.emit(self)
