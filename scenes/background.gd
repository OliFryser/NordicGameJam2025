extends Node2D


@export var sprite: Sprite2D
@export var backgrounds : Array[Texture]
var backgroundIndex = 0

func showNextBackground():
	backgroundIndex += 1
	if(backgroundIndex < backgrounds.size()):
		sprite.texture = backgrounds[backgroundIndex]
