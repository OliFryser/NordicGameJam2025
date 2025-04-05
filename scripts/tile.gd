@tool
class_name Tile
extends Node2D


@export var line_2d: Line2D
@export var color_rect: ColorRect
@export var size : int = 100


func setup(size : int):
	self.size = size
	line_2d.clear_points()
	var offset := size * .5
	line_2d.add_point(Vector2(offset, offset))
	line_2d.add_point(Vector2(-offset, offset))
	line_2d.add_point(Vector2(-offset, -offset))
	line_2d.add_point(Vector2(offset, -offset))
	color_rect.set_size(Vector2(size, size))
	color_rect.set_position(Vector2(-offset, -offset))
