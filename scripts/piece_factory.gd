class_name Piece_Factory

extends Object

@export var happy: Texture
@export var sad: Texture
@export var disgusted: Texture
@export var angry: Texture

func build(mood: Mood.Mood) -> Texture:
	match mood:
		Mood.Mood.HAPPY:
			return happy
		Mood.Mood.ANGRY:
			return angry
		Mood.Mood.DISGUSTED:
			return disgusted
		Mood.Mood.SAD:
			return sad
	return null
