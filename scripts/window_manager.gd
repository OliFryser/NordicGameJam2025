extends Node


@export var managed_windows: Array[Draggable]
@export var offset: int

func _ready() -> void:
	for window in managed_windows:
		window.connect("window_dragged", _on_dragged_window)
		_set_z_indices()


func _set_z_indices():
	for i in range(managed_windows.size()):
		managed_windows[i].z_index = offset * (i + 1)


func _on_dragged_window(dragged_window: Draggable):
	var window_index := managed_windows.rfind(dragged_window)
	if window_index < 0:
		return

	managed_windows.remove_at(window_index)
	managed_windows.append(dragged_window)
	_set_z_indices()
