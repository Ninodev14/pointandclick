extends Area2D

@onready var levier = $Levier 
@onready var animation_player = $Levier/Levier
@onready var demnieur = $"../DemineurActiveur"
@onready var coffreFort = $"../coffreFort"
@onready var screen =  $"../screen"
@onready var cable =  $"../Cable"
@onready var spineur =  $"../SpineurSprite"

func _ready() -> void:

	levier.connect("pressed", Callable(self, "_on_levier_pressed"))

	demnieur.visible = false
	coffreFort.visible = false
	screen.visible = false
	cable.visible = false
	spineur.visible = false

func _on_levier_pressed() -> void:
	animation_player.play("On")
	demnieur.visible = true
	coffreFort.visible = true
	screen.visible = true
	cable.visible = true
	spineur.visible = true
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
