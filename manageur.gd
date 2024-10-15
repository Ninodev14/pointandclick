extends Node

# Charge les différents curseurs personnalisés
@export var default_cursor = preload("res://cursor.png")
@export var hover_cursor = preload("res://cursor-hover.png")
@export var click_cursor = preload("res://cursor-click.png")

var saved_text = ""
var saved_position = Vector2()
var saved_rotation = 0.0

var music_volume: float = 0.5
var sfx_volume: float = 0.5

# Références aux AudioStreamPlayers
@onready var music_player: AudioStreamPlayer2D

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

# Fonction pour définir le volume de la musique
func set_music_volume(value: float) -> void:
	music_volume = value
	# Appliquer le volume au MusicPlayer
	if music_player:
		music_player.volume_db = linear_to_db(music_volume)  # Convertit le volume en dB

# Fonction pour définir le volume des effets sonores
func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	# Ici, vous pouvez ajouter la logique pour appliquer le volume aux effets sonores si nécessaire

# Optionnel : Méthode pour mettre à jour le volume de la musique au démarrage
func update_music_volume() -> void:
	set_music_volume(music_volume)  # Applique le volume initial
