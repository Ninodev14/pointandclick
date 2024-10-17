extends Area2D

var dragging = false
var offset = Vector2.ZERO
var initial_position = Vector2.ZERO
var last_area: Area2D = null 
var vitreCassez = 0

@onready var Marteau = $Marteau
@onready var animation_player = $"../Levier/Levier/Levier"
@onready var button = $"../Levier/Levier" 

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
			_on_drag_released()

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() + offset

func _on_drag_released() -> void:
	if last_area != null:
		_check_drop_zone(last_area)
	else:
		_reset_position()

func _on_area_entered(area: Area2D) -> void:
	last_area = area

func _on_area_exited(area: Area2D) -> void:
	if last_area == area:
		last_area = null

func _check_drop_zone(area: Area2D) -> void:
	if area.is_in_group("Vitre"): 
		if vitreCassez == 0 :
			animation_player.play("Off")
			animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
			button.disabled = false
			vitreCassez = 1
		_reset_position()
	else:
		_reset_position()

func _on_animation_finished() -> void:
	_reset_position() 

func _reset_position() -> void:
	position = initial_position
