@tool
class_name BoardGenerator
extends Node


@export var tileScene : PackedScene
@export var tileSize : int = 20
@export var width : int = 20:
	set(p_width):
		width = p_width
		if Engine.is_editor_hint():
			create_board(width, height)
@export var height : int = 20:
	set(p_height):
		height = p_height
		if Engine.is_editor_hint():
			create_board(width, height)
@export var board: Board


func create_board(width: int, height: int):
	board.position = Vector2(-tileSize * width * .5 + tileSize * .5, -tileSize * height * .5 + tileSize * .5)
	for child in board.get_children():
		board.remove_child(child)
		child.queue_free()

	for y in range(height):
		for x in range(width):
			var tile := tileScene.instantiate()
			tile.setup(tileSize)
			board.add_child(tile)
			tile.position = Vector2(x * tileSize, y * tileSize)


func _ready():
	create_board(width, height)
