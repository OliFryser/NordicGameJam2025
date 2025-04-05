class_name Board_Model
extends RefCounted

var models: Array[Model] = []
var size_x: int
var size_y: int

# (0,2) (1,2) (2,2)
#
# (0,1) (1,1) (2,1)
#
# (0,0) (1,0) (2,0)

func _init(x: int, y: int) -> void:
	size_x = x
	size_y = y
	models = []
	for j in range(y):
		for i in range(x):
			var m = Model.new()
			m.Mood = _random_mood()
			m.x = i
			m.y = j
			#m.piece = 
			models.append(m)
	
	
func _update_board() -> void:
	var matches: Array[Model] = _get_all_matches()
	
	for m in matches: 
		models.erase(m)
	
	for model in models:
		var matches_below_model: int = matches.count(func (other) -> bool: 
			return model.x == other.x && model.y > other.y)
		model.y -= matches_below_model
	
	_refill()
	
func _refill() -> void:
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
		model.mood = _random_mood()
	
func _get_all_matches() -> Array[Model]:
	var matches: Array[Model] = []
	for m1 in models:
		var m1_matches: Array[Model] = []
		for m2 in models:
			if m1 == m2:
				continue
			if _is_matching_neighbor(m1, m2):
				m1_matches.append_array([m1, m2])
		if m1_matches.size() == 3:
			matches.append_array(m1_matches)
	
	var unique_matches = _unique(matches)
	return unique_matches

func _is_matching_neighbor(m1, m2) -> bool:
	if abs(m1.x - m2.x) != 1 and abs(m1.y - m2.y) != 1:
		return false
	
	return m1.mood == m2.mood
	
func _unique(arr: Array[Model]) -> Array[Model]:
	var seen = []
	for model in arr:
		if model not in seen:
			seen.append(model)
	return seen
	
func _random_mood():
	var mood_values = Mood.Mood.values()
	var random_mood = mood_values[randi() % mood_values.size()]
	return random_mood
