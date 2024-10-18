extends Area2D

@onready var notes_area2d: Area2D = $"../NoteContener"
@onready var notes_button: Button = $Notes
@onready var pause_button: Button = $Pause
@onready var help_button: Button = $Help
@onready var main_script: Node2D = get_parent()
@onready var help_animation = $Help/Help
@onready var pause_animation = $Pause/Pause
@onready var notes_animation = $Notes/Notes

func _ready() -> void:
	notes_button.pressed.connect(on_notes_button_pressed)
	pause_button.pressed.connect(on_pause_button_pressed)
	help_button.pressed.connect(on_help_button_pressed)
	notes_area2d.visible = false

func on_notes_button_pressed() -> void:
	notes_area2d.visible = not notes_area2d.visible
	if notes_area2d.visible:
		main_script.pause_timer()
	else:
		main_script.resume_timer()
	notes_animation.play("Click")

func on_pause_button_pressed() -> void:
	pause_animation.play("Click")
	

func on_help_button_pressed() -> void:
	help_animation.play("Click")
	
