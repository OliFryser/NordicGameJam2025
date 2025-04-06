extends Node2D


@export var match3 : Match3
@export var score_label : Label
@export var background : Background

func _ready() -> void:
	match3.new_points.connect(on_points_received)


func on_points_received(reward: int, total: int):
	score_label.text = "Salary: $%d" % total
	background.showNextBackground()
