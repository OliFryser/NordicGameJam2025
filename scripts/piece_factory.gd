class_name PieceFactory
extends Resource


@export var happy: Texture
@export var sad: Texture
@export var disgusted: Texture
@export var angry: Texture
@export var scared: Texture
@export var pieceScene : PackedScene


func build(mood: Enums.Mood) -> Piece:
	var texture = get_texture(mood)
	assert(texture)
	var piece = pieceScene.instantiate()
	piece.set_texture(texture)
	return piece


func get_texture(mood: Enums.Mood) -> Texture:
	match mood:
		Enums.Mood.HAPPY:
			return happy
		Enums.Mood.ANGRY:
			return angry
		Enums.Mood.DISGUSTED:
			return disgusted
		Enums.Mood.SAD:
			return sad
		Enums.Mood.SCARED:
			return scared
		_:
			return null
