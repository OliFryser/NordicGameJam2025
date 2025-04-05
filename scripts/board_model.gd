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
	var index = models.find_custom(func (model: Model) -> int: return model.piece == piece)
	return models[index]
	
	
func _swap_positions(model1: Model, model2: Model) -> void:
	var x1 = model1.x
	var y1 = model1.y
	model1.x = model2.x
	model1.y = model2.y
	model2.x = x1
	model2.y = y1
	

func descend_models() -> void:
	for model in models: 
		var models_below: int = models.count(func (other) -> bool: 
			return model.x == other.x && model.y > other.y)
		model.y = models_below


func refill() -> void:
	# assumes everything has fallen down
	for column in range(size_x):
		var highest_up: int = _max(column)
		var amount_to_fill = size_y - highest_up
		_fill_column(column, amount_to_fill)


func _max(column: int):
	var high = 0
	for model in models:
		if model.x != column:
			continue
		if model.y > high:
			high = model.y
	return high


func _fill_column(column: int, amount: int) -> void:
	for y in range(amount, size_y):
		var model = Model.new()
		model.x = column
		model.y = y
		model.mood = Enums.Mood.values().pick_random()
		model.piece = pieceFactory.build(model.mood)


func get_all_matches() -> Array[Model]:
	var matches: Array[Model] = []
	for m1 in models:
		var m1_matches: Array[Model] = []
		for m2 in models:
			if m1 == m2:
				continue
			if _is_matching_neighbor(m1, m2):
				m1_matches.append_array([m1, m2])
		if m1_matches.size() >= 3:
			matches.append_array(m1_matches)
	
	var unique_matches = _unique(matches)
	return unique_matches


func _is_neighbor(m1: Model, m2: Model) -> bool:
	var is_horizontal_neighbor = m1.x == m2.x and abs(m1.y - m2.y) == 1
	var is_vertical_neighbor = m1.y == m2.y and abs(m1.x - m2.x) == 1
	return is_horizontal_neighbor or is_vertical_neighbor


func _is_matching_neighbor(m1, m2) -> bool:
	return _is_neighbor(m1, m2) and m1.mood == m2.mood


func _unique(arr: Array[Model]) -> Array[Model]:
	var seen = []
	for model in arr:
		if model not in seen:
			seen.append(model)
	return seen
