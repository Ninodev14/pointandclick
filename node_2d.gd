extends Node2D

@onready var timer = Timer.new()
@onready var element_to_keep = $TextEdit
@onready var label = $Label
@onready var reset_button = $ResetButton

func _ready() -> void:
	add_child(timer)
	timer.wait_time = 60
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

	if element_to_keep == null:
		print("Erreur : 'TextEdit' n'a pas été trouvé")
		return

	reset_button.connect("pressed", Callable(self, "_on_reset_button_pressed"))
	reset_button.disabled = true
	_restore_element_data()
	set_process(true)

func _process(delta: float) -> void:
	if not timer.is_stopped():
		var time_left = int(timer.time_left)
		label.text = str(time_left) + " s restantes"

func _on_timer_timeout() -> void:
	_save_element_data()
	reset_button.disabled = false

func _save_element_data() -> void:
	Manageur.saved_text = element_to_keep.text

func _restore_element_data() -> void:
	element_to_keep.text = Manageur.saved_text

func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()
	timer.start()
	reset_button.disabled = true
