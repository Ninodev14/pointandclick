extends Area2D

@onready var bouton = $marteauBtn
@onready var animation_player = $"../Levier/Levier/Levier"
@onready var button = $"../Levier/Levier" 

func _ready() -> void:
	bouton.connect("pressed", Callable(self, "_on_bouton_pressed"))


func _on_bouton_pressed() -> void:
	animation_player.play("Off")
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
	bouton.disabled = true
	button.disabled = false
