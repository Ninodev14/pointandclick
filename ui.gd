extends Area2D

@onready var notes_area2d: Area2D = $"../NoteContener"
@onready var notes_button: Button = $Notes
@onready var main_script: Node2D = get_parent()

func _ready() -> void:
	notes_button.pressed.connect(on_notes_button_pressed)
	notes_area2d.visible = false

func on_notes_button_pressed() -> void:
	notes_area2d.visible = not notes_area2d.visible
	
	if notes_area2d.visible:
		main_script.pause_timer()
	else:
		main_script.resume_timer()
