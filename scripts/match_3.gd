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
	set_pieces()
	

func set_pieces():
	var tileSize := boardGenerator.tileSize
	_initialize_models(boardModel.models)

func _get_screen_position_from_model(model: Model) -> Vector2:
	var tileSize := boardGenerator.tileSize
	return Vector2(model.x * tileSize, (height - model.y - 1) * tileSize)


func _animate_swap(selection: Piece, piece: Piece):
	var selectionPosition := selection.position
	var tween := get_tree().create_tween()
	tween.set_parallel()
	selection.update_swap_position(piece.position, tween)
	piece.update_swap_position(selectionPosition, tween)
	await tween.finished


func on_piece_clicked(piece: Piece):
	if (selection == piece):
		selection.hide_selection()
		selection = null
		return
		
	if selection and boardModel.is_neighbor(selection, piece):
		await _animate_swap(selection, piece)
	
		if boardModel.is_valid_swap(piece, selection):
			print("match")
			boardModel.swap(piece, selection)
			selection.hide_selection()
			selection = null
			update_board()
		else:
			await _animate_swap(selection, piece)
			selection.hide_selection()
			selection = null
	
	else:
		print("No match")
		if selection:
			selection.hide_selection()
		selection = piece
		selection.display_selection()
	

func update_board():
	var tileSize = boardGenerator.tileSize
	var matches := boardModel.get_all_matches()
	
	boardModel.remove_models(matches)
	for model in matches:
		model.piece.disappear()
	
	boardModel.descend_models()
	var new_models := boardModel.refill()
	_initialize_models(new_models)
	for model in boardModel.models:
		model.piece.update_position(_get_screen_position_from_model(model))

func _initialize_models(models: Array[Model]) -> void:
	for model in models:
		model.piece.position = _get_screen_position_from_model(model) + Vector2(0, -6 * boardGenerator.tileSize)
		model.piece.update_position(_get_screen_position_from_model(model))
		model.piece.set_size(pieceSize, boardGenerator.tileSize)
		model.piece.clicked.connect(on_piece_clicked)
		boardGenerator.board.add_child(model.piece)
