extends Area2D

@onready var cafeAnnime = $cafeBtn/cafeAnnim
@onready var cafe = $cafeBtn 
var sondCafe : AudioStreamPlayer2D

func _ready() -> void:
	# Connecte le signal 'pressed' du bouton à une méthode
	cafe.connect("pressed", Callable(self, "_on_bouton_pressed"))

	cafeAnnime.play("Unpressed")
	sondCafe = $cafeSound
func _on_bouton_pressed() -> void:
	cafeAnnime.play("pressed")
	sondCafe.play()

func _reset_animation() -> void:
	cafeAnnime.play("Unpressed")
