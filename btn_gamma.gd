extends Area2D

@onready var btn1: Button = $btnGamma1
@onready var btn2: Button = $btnGamma2
@onready var btn3: Button = $btnGamma3

@onready var anim_player1: AnimatedSprite2D = $btnGamma1/btnGammaAnnim
@onready var anim_player2: AnimatedSprite2D = $btnGamma2/btnGammaAnnim
@onready var anim_player3: AnimatedSprite2D = $btnGamma3/btnGammaAnnim

# Variables pour stocker l'état "On/Off" de chaque bouton
var is_btn1_on: bool = false
var is_btn2_on: bool = false
var is_btn3_on: bool = false

# Cette fonction est appelée lorsque la scène est prête
func _ready() -> void:
	# Connexion des signaux de clic des boutons aux fonctions correspondantes
	btn1.connect("pressed", Callable(self, "_on_btn1_pressed"))
	btn2.connect("pressed", Callable(self, "_on_btn2_pressed"))
	btn3.connect("pressed", Callable(self, "_on_btn3_pressed"))

# Fonction appelée lorsque le bouton 1 est pressé
func _on_btn1_pressed() -> void:
	# Basculer l'état entre "On" et "Off"
	if is_btn1_on:
		anim_player1.play("On")
	else:
		anim_player1.play("Off")
	is_btn1_on = !is_btn1_on  # Inverse l'état

# Fonction appelée lorsque le bouton 2 est pressé
func _on_btn2_pressed() -> void:
	# Basculer l'état entre "On" et "On"
	if is_btn2_on:
		anim_player2.play("On")
	else:
		anim_player2.play("Off")
	is_btn2_on = !is_btn2_on  # Inverse l'état

# Fonction appelée lorsque le bouton 3 est pressé
func _on_btn3_pressed() -> void:
	# Basculer l'état entre "On" et "On"
	if is_btn3_on:
		anim_player3.play("On")
	else:
		anim_player3.play("Off")
	is_btn3_on = !is_btn3_on  # Inverse l'état
