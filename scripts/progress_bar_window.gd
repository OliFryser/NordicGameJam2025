class_name ProgressBarWindow
extends Node2D


@export var progressForNextLevel : int = 600
@export var progressTick: PackedScene
@export var progressBar: HBoxContainer
const MAX_TICKS = 47
var currentTicks : int = 0

signal levelCompleted

func update_progress_bar(points: int):
	if points >= progressForNextLevel:
		for child in progressBar.get_children():
			child.queue_free()
		levelCompleted.emit()

	points %= progressForNextLevel
	var progress := points / (progressForNextLevel as float)
	var newTicks := ceili(MAX_TICKS * progress)
	newTicks = min(newTicks, MAX_TICKS)
	var ticksToSpawn := newTicks - currentTicks
	for i in range(ticksToSpawn):
		var tick := progressTick.instantiate()
		progressBar.add_child(tick)
		
	currentTicks = newTicks	
