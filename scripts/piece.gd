class_name Piece
extends Node2D


@export var sprite2D : Sprite2D


func set_texture(texture: Texture):
	sprite2D.texture = texture
	var size := sprite2D.texture.get_size()
	sprite2D.scale = sprite2D.scale / size
