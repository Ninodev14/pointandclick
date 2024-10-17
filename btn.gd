extends Area2D

@onready var btnAnnime = $Button/btnAnnim
@onready var bouton = $Button
@onready var timer = Timer.new()
@onready var sondBtn : AudioStreamPlayer2D = $btnSound
@onready var explosionAnim = $"../MainScene"  # Référence à l'animation d'explosion
@onready var MenueExplosion = $"../MenueExplosion"  
@onready var noClick = $"../NoClick"
@onready var resetButton = $"../ResetButton"

var explosion_finished = false  # Variable pour vérifier si l'animation d'explosion est terminée

func _ready() -> void:
	bouton.connect("pressed", Callable(self, "_on_bouton_pressed"))
	bouton.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	bouton.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_reset_animation"))

	# Connecter le signal sans utiliser d'argument
	explosionAnim.connect("animation_finished", Callable(self, "_on_explosion_finished"))

	btnAnnime.play("Unpressed")


func _on_bouton_pressed() -> void:
	btnAnnime.play("pressed")
	sondBtn.play()
	timer.start()
	noClick.show()
	explosionAnim.play("Explosion")


func _reset_animation() -> void:
	btnAnnime.play("Unpressed")


func _on_mouse_entered() -> void:
	Manageur.set_hover_cursor()


func _on_mouse_exited() -> void:
	Manageur.reset_cursor()


# Ne pas attendre d'argument ici, car le signal ne transmet pas d'argument
func _on_explosion_finished() -> void:
	explosion_finished = true  # L'animation "Explosion" est terminée
	_check_all_animations_finished()  # Vérification si une action doit être déclenchée


func _check_all_animations_finished() -> void:
	if explosion_finished:
		resetButton.show()
		MenueExplosion.show()  # Par exemple, montrer un menu
		print("L'animation d'explosion est terminée.")
