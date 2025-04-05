@tool
class_name Match3
extends Node2D


@export var width : int = 20:
	set(p_width):
		width = p_width
		if Engine.is_editor_hint():
			boardGenerator.create_board(boardModel)
@export var height : int = 20:
	set(p_height):
		height = p_height
		if Engine.is_editor_hint():
			boardGenerator.create_board(boardModel)
@export var boardGenerator : BoardGenerator
@export var pieceFactory: PieceFactory
@export var pieceSize : int = 60
var boardModel : BoardModel


func _ready():
	boardModel = BoardModel.new(width, height, pieceFactory)
	boardGenerator.create_board(boardModel)
	set_pieces(boardModel)
	

func set_pieces(boardModel: BoardModel):
	var tileSize = boardGenerator.tileSize
	for model in boardModel.models:
		model.piece.position = Vector2(model.x * tileSize, model.y * tileSize)
		model.piece.sprite2D.scale *= pieceSize
		boardGenerator.board.add_child(model.piece)
		
		
