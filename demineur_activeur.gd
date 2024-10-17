extends Area2D

var demineur: Node2D
@onready var demineurClose = $"../Demineur/DemineurSortis"

func _ready() -> void:
	demineur = $"../Demineur"
	$DemineurActiveurBtn.pressed.connect(_on_DemineurActiveurBtn_pressed)
	demineur.visible = false
	demineurClose.pressed.connect(_on_DemineurClose_pressed)  # Connexion du signal pour le bouton DemineurSortis

func _on_DemineurActiveurBtn_pressed() -> void:
	demineur.visible = true

func _on_DemineurClose_pressed() -> void:
	demineur.visible = false  # Faire disparaître le demineur

func _process(delta: float) -> void:
	pass
