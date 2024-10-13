extends Node

# Charge les différents curseurs personnalisés
@export var default_cursor = preload("res://cursor.png")
@export var hover_cursor = preload("res://cursor-hover.png")
@export var click_cursor = preload("res://cursor-click.png")
var saved_text = ""
var saved_position = Vector2()
var saved_rotation = 0.0

func _ready() -> void:
	set_default_cursor()

func set_default_cursor() -> void:
	Input.set_custom_mouse_cursor(default_cursor)

func set_hover_cursor() -> void:
	Input.set_custom_mouse_cursor(hover_cursor)

func set_click_cursor() -> void:
	Input.set_custom_mouse_cursor(click_cursor)

func reset_cursor() -> void:
	Input.set_custom_mouse_cursor(default_cursor)
