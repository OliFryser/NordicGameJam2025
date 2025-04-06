class_name BoardModel
extends RefCounted


var models: Array[Model] = []
var size_x: int
var size_y: int
var pieceFactory: PieceFactory


# (0,2) (1,2) (2,2)
#
# (0,1) (1,1) (2,1)
#
# (0,0) (1,0) (2,0)

func _init(x: int, y: int, pieceFactory : PieceFactory) -> void:
	size_x = x
	size_y = y
	self.pieceFactory = pieceFactory
	models = []
	for j in range(y):
		for i in range(x):
			var m := Model.new()
			m.mood = Enums.Mood.values().pick_random()
			m.x = i
			m.y = j
			m.piece = pieceFactory.build(m.mood)
			models.append(m)
			
			
func is_valid_swap(piece1: Piece, piece2: Piece) -> bool: 
	var model1 = _get_model(piece1)
	var model2 = _get_model(piece2)
	if !_is_neighbor(model1, model2):
		return false
	
	_swap_positions(model1, model2)
	var matches = get_all_matches().size()
	_swap_positions(model1, model2)
	return matches > 0
	
	
func swap(piece1: Piece, piece2: Piece):
	var model1 = _get_model(piece1)
	var model2 = _get_model(piece2)
	_swap_positions(model1, model2)


func remove_models(models_to_remove: Array[Model]):
	for model in models_to_remove:
		models.erase(model)
	
	
func _get_model(piece: Piece) -> Model:
	for model in models:
		if model.piece == piece:
			return model
	printerr("No model with that piece!")
	return null
	
	
func _swap_positions(model1: Model, model2: Model) -> void:
	var x1 = model1.x
	var y1 = model1.y
	model1.x = model2.x
	model1.y = model2.y
	model2.x = x1
	model2.y = y1
	

func descend_models() -> void:
	var copy = models.duplicate(true)
	for model in models: 
		var models_below = 0
		for other in copy:
			if model.x == other.x and model.y > other.y:
				models_below += 1
		model.y = models_below


func refill() -> Array[Model]:
	# assumes everything has fallen down
	var new_models: Array[Model] = []
	for column in range(size_x):
		var highest_up: int = _max(column)
		var amount_to_fill = size_y - highest_up - 1
		var new_column_models = _fill_column(column, amount_to_fill)
		new_models.append_array(new_column_models)
	return new_models


func _max(column: int):
	var high = 0
	for model in models:
		if model.x != column:
			continue
		if model.y > high:
			high = model.y
	return high


func _fill_column(column: int, amount: int) -> Array[Model]:
	var new_models: Array[Model]
	for y in range(size_y - amount, size_y, 1):
		var model = Model.new()
		model.x = column
		model.y = y
		model.mood = Enums.Mood.values().pick_random()
		model.piece = pieceFactory.build(model.mood)
		new_models.append(model)
	return new_models


func get_all_matches() -> Array[Model]:
	var matches: Array[Model] = []
	for m1 in models:
		var m1_horizontal_matches: Array[Model] = []
		var m1_vertical_matches: Array[Model] = []
		for m2 in models:
			if m1 == m2:
				continue
			if _is_horizontal_matching_neighbor(m1, m2):
				m1_horizontal_matches.append_array([m1, m2])
			if _is_vertical_matching_neighbor(m1, m2):
				m1_vertical_matches.append_array([m1, m2])
		if m1_horizontal_matches.size() >= 3:
			matches.append_array(m1_horizontal_matches)
		if m1_vertical_matches.size() >= 3:
			matches.append_array(m1_vertical_matches)
	
	var unique_matches = _unique(matches)
	return unique_matches


func is_neighbor(piece1: Piece, piece2: Piece):
	return _is_neighbor(_get_model(piece1), _get_model(piece2))


func _is_neighbor(m1: Model, m2: Model) -> bool:
	return _is_horizontal_neighbor(m1, m2) or _is_vertical_neighbor(m1, m2)


func _is_horizontal_neighbor(m1: Model, m2: Model) -> bool:
	return m1.x == m2.x and abs(m1.y - m2.y) == 1


func _is_vertical_neighbor(m1: Model, m2: Model) -> bool:
	return m1.y == m2.y and abs(m1.x - m2.x) == 1


func _is_horizontal_matching_neighbor(m1, m2) -> bool:
	return _is_horizontal_neighbor(m1, m2) and m1.mood == m2.mood


func _is_vertical_matching_neighbor(m1, m2) -> bool:
	return _is_vertical_neighbor(m1, m2) and m1.mood == m2.mood


func _unique(arr: Array[Model]) -> Array[Model]:
	var seen : Array[Model] = []
	for model in arr:
		if model not in seen:
			seen.append(model)
	return seen
