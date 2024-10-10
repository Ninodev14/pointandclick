extends Node

# Charge les différents curseurs personnalisés
@export var default_cursor = preload("res://cursor.png")
@export var hover_cursor = preload("res://cursor-hover.png")
@export var click_cursor = preload("res://cursor-click.png")
var saved_text = ""
var saved_position = Vector2()
var saved_rotation = 0.0
# Singleton (auto-chargé) CursorManager
func _ready() -> void:
	# Définir le curseur par défaut au démarrage
	set_default_cursor()

# Méthode pour définir le curseur par défaut
func set_default_cursor() -> void:
	Input.set_custom_mouse_cursor(default_cursor)

# Méthode pour définir le curseur de survol
func set_hover_cursor() -> void:
	Input.set_custom_mouse_cursor(hover_cursor)

# Méthode pour définir le curseur de clic (par exemple, quand on clique sur un bouton)
func set_click_cursor() -> void:
	Input.set_custom_mouse_cursor(click_cursor)

# Méthode pour réinitialiser tous les curseurs à leur état par défaut
func reset_cursor() -> void:
	Input.set_custom_mouse_cursor(default_cursor)
