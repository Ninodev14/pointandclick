extends Node2D

var is_dragging = false



func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = true
		elif event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = false

func _process(delta):
	if is_dragging:
		self.position = get_global_mouse_position()
