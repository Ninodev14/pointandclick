extends Area2D

var dragging = false
var offset = Vector2.ZERO
var last_area = null 
var initial_position = Vector2.ZERO 

func _ready() -> void:
	initial_position = position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			if self.get_global_mouse_position().distance_to(position) < 50:
				dragging = true
				offset = position - self.get_global_mouse_position()
		elif event.is_action_released("left_click"):
			dragging = false
			if last_area != null:
				_detect_color(last_area)
			else:
				_reset_position()

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() + offset

func _on_area_entered(area: Area2D) -> void:
	last_area = area

func _on_area_exited(area: Area2D) -> void:
	if last_area == area:
		last_area = null

func _detect_color(area: Area2D) -> void:
	if area.is_in_group("Blanc"):
		print("La pince a touché le blanc!")
	elif area.is_in_group("Noir"):
		print("La pince a touché le noir!")
	elif area.is_in_group("Cyan"):
		print("La pince a touché le cyan!")
	elif area.is_in_group("Magenta"):
		print("La pince a touché le magenta!")
	else:
		print("Couleur inconnue touchée.")

func _reset_position() -> void:
	print("Aucune zone détectée. La pince revient à sa position initiale.")
	position = initial_position
