extends Area2D

@onready var btnAnnime = $Button/btnAnnim
@onready var bouton = $Button
@onready var timer = Timer.new()
@onready var sondBtn : AudioStreamPlayer2D = $btnSound
@onready var cafeArea = $"../Cafe"

func _ready() -> void:
	bouton.connect("pressed", Callable(self, "_on_bouton_pressed"))
	bouton.connect("mouse_entered", Callable(self, "_on_mouse_entered"))  # Connexion du signal pour l'entrée de la souris
	bouton.connect("mouse_exited", Callable(self, "_on_mouse_exited"))    # Connexion du signal pour la sortie de la souris

	add_child(timer)
	timer.wait_time = 0.5 
	timer.one_shot = true  
	timer.connect("timeout", Callable(self, "_reset_animation"))

	btnAnnime.play("Unpressed")
	cafeArea.hide()

func _on_bouton_pressed() -> void:
	btnAnnime.play("pressed")
	sondBtn.play()
	timer.start()

	if cafeArea.visible:
		cafeArea.hide()
	else:
		cafeArea.show()

func _reset_animation() -> void:
	btnAnnime.play("Unpressed")

# Méthode appelée lorsque la souris entre dans le bouton
func _on_mouse_entered() -> void:
	Manageur.set_hover_cursor()  # Changement du curseur à celui de "hover" lors du survol

# Méthode appelée lorsque la souris sort du bouton
func _on_mouse_exited() -> void:
	Manageur.reset_cursor()  # Réinitialisation du curseur lorsqu'il quitte le bouton
