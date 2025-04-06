@tool
class_name BoardGenerator
extends Node


@export var tileScene : PackedScene
var tileSize : int
@export var board: Board


func create_board(boardModel : BoardModel, tileSize : int):
	self.tileSize = tileSize 
	var boardOffsetX := -tileSize * boardModel.size_x * .5 + tileSize * .5
	var boardOffsetY := -tileSize * boardModel.size_y * .5 + tileSize * .5
	board.position = Vector2(boardOffsetX, boardOffsetY)
	for child in board.get_children():
		board.remove_child(child)
		child.queue_free()

	for y in range(boardModel.size_y):
		for x in range(boardModel.size_x):
			var tile := tileScene.instantiate()
			tile.setup(tileSize)
			board.add_child(tile)
			tile.position = Vector2(x * tileSize, y * tileSize)
