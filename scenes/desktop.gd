extends Node2D


@export var match3 : Match3
@export var score_label : Label
@export var background : Background
@export var progressBarWindow: ProgressBarWindow
@export var supervisorWindow: SuperviserWindow
@export var dialogueWindow: DialogueWindow


func _ready() -> void:
	match3.new_points.connect(on_points_received)
	progressBarWindow.levelCompleted.connect(on_level_completed)
	supervisorWindow.say.connect(on_dialogue_request)


func on_dialogue_request(message: String):
	dialogueWindow.showMessage(message)
	

func on_level_completed():
	background.showNextBackground()


func on_points_received(reward: int, total: int):
	score_label.text = "Salary: $%d" % total
	progressBarWindow.update_progress_bar(total)
	
