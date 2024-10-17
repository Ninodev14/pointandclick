extends Node


@export var default_cursor = preload("res://cursor.png")
@export var hover_cursor = preload("res://cursor-hover.png")
@export var click_cursor = preload("res://cursor-click.png")

var Startimer = 0
var saved_text = ""
var saved_position = Vector2()
var saved_rotation = 0.0

var music_volume: float = 0.5
var sfx_volume: float = 0.5

@onready var music_player: AudioStreamPlayer2D
var Earthboom71 = ""

func _ready() -> void:
	set_default_cursor()
	update_music_volume() 


func set_default_cursor() -> void:
	Input.set_custom_mouse_cursor(default_cursor)

func set_hover_cursor() -> void:
	Input.set_custom_mouse_cursor(hover_cursor)

func set_click_cursor() -> void:
	Input.set_custom_mouse_cursor(click_cursor)

func reset_cursor() -> void:
	Input.set_custom_mouse_cursor(default_cursor)

func set_music_volume(value: float) -> void:
	music_volume = value

	if music_player:
		music_player.volume_db = linear_to_db(music_volume)


func set_sfx_volume(value: float) -> void:
	sfx_volume = value

func update_music_volume() -> void:
	set_music_volume(music_volume) 
var mouse_sens= 175.0

func _physics_process(delta):

	var direction: Vector2
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()

	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	var movement = mouse_sens * direction * delta
	if (movement):
		get_viewport().warp_mouse(mouse_pos+movement)


func _input(event):
	if event.is_action_pressed("Enter"):
		var mouse_click_event = InputEventMouseButton.new()
		mouse_click_event.button_index = 1
		mouse_click_event.pressed = true
		mouse_click_event.position = get_viewport().get_mouse_position()

		Input.parse_input_event(mouse_click_event)
