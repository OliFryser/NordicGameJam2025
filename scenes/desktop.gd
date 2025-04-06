extends Node2D


@export var match3 : Match3
@export var score_label : Label
@export var background : Background
@export var progressBarWindow: ProgressBarWindow
@export var supervisorWindow: SuperviserWindow
@export var dialogueWindow: DialogueWindow
@export var closeWindowButton : Button
@export var rewardLabel : Label
@export var cursorIdle: Texture
@export var cursorClick: Texture


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _ready() -> void:
	Input.set_custom_mouse_cursor(cursorIdle)
	
	rewardLabel.pivot_offset = Vector2(rewardLabel.size * .5)
	rewardLabel.scale = Vector2(0,0)
	match3.new_points.connect(on_points_received)
	progressBarWindow.levelCompleted.connect(on_level_completed)
	supervisorWindow.say.connect(on_dialogue_request)
	closeWindowButton.pressed.connect(on_close_game)


func on_close_game():
	get_tree().quit()


func on_dialogue_request(message: String):
	dialogueWindow.showMessage(message)
	

func on_level_completed(level: int):
	background.showNextBackground()
	supervisorWindow.start_level_completion_response(level)


func on_points_received(reward: int, total: int):
	score_label.text = "Salary: $%d" % total
	progressBarWindow.update_progress_bar(total)
	supervisorWindow.set_idle()
	supervisorWindow.start_point_response(reward)
	show_reward_label(reward)


func show_reward_label(reward: int):
	rewardLabel.scale = Vector2(0, 0)
	rewardLabel.modulate = Color.WHITE
	var tween := create_tween()
	rewardLabel.text = "$ %d" % reward
	var scaleTime := .2
	tween.tween_property(rewardLabel, "scale", Vector2(1, 1), scaleTime)\
			.set_ease(Tween.EASE_OUT)\
			.from_current()
	tween.tween_property(rewardLabel, "modulate", Color(1, 1, 1, 0), .1)\
			.set_ease(Tween.EASE_IN)\
			.set_delay(scaleTime + .2)
