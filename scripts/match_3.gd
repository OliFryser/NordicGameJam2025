@tool
class_name Match3
extends Node2D

var selection: Piece


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
		model.piece.position = Vector2(model.x * tileSize, (height - model.y - 1) * tileSize)
		model.piece.set_size(pieceSize, tileSize)
		model.piece.clicked.connect(on_piece_clicked)
		boardGenerator.board.add_child(model.piece)
	
		
func on_piece_clicked(piece: Piece):
	if (selection == piece):
		return
	if selection and boardModel.is_valid_swap(piece, selection):
		print("match")
		boardModel.swap(piece, selection)
		selection.hide_selection()
		selection = null
		update_board()
	else:
		print("No match")
		if selection:
			selection.hide_selection()
		selection = piece
		piece.display_selection()

func update_board():
	var tileSize = boardGenerator.tileSize
	var matches := boardModel.get_all_matches()
	boardModel.remove_models(matches)
	# animate disappearance (and free)
	var matchedPieces := matches.map(func (m: Model): return m.piece)
	for model in matches:
		model.piece.disappear()
	boardModel.descend_models()
	# animate all models to their positions
	for model in boardModel.models:
		model.piece.update_position(Vector2(model.x * tileSize, model.y * tileSize))
	# refill 
	# animate refill
