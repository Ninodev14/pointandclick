extends Area2D

var explosionAnnim = 0
@onready var btnAnnime = $Button/btnAnnim
@onready var bouton = $Button
@onready var timer = Timer.new()
@onready var sondBtn : AudioStreamPlayer2D = $btnSound
@onready var explosionAnim = $"../MainScene"  
@onready var MenueExplosion = $"../MenueExplosion"  
@onready var noClick = $"../NoClick"
@onready var resetButton = $"../ResetButton"

var explosion_finished = false  

func _ready() -> void:
	bouton.connect("pressed", Callable(self, "_on_bouton_pressed"))
	bouton.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	bouton.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_reset_animation"))

	explosionAnim.connect("animation_finished", Callable(self, "_on_explosion_finished"))

	btnAnnime.play("Unpressed")

func _on_bouton_pressed() -> void:
	if explosionAnim.is_playing():
		return
	btnAnnime.play("pressed")
	sondBtn.play()
	timer.start()
	noClick.show()
	explosionAnim.play("Explosion")
	explosionAnnim = 1
	Manageur.Earthboom71 = 1
	print(Manageur.Earthboom71)
	
func _reset_animation() -> void:
	btnAnnime.play("Unpressed")

func _on_mouse_entered() -> void:
	Manageur.set_hover_cursor()

func _on_mouse_exited() -> void:
	Manageur.reset_cursor()

func _on_explosion_finished() -> void:
	explosion_finished = true  
	_check_all_animations_finished()  

func _check_all_animations_finished() -> void:
	if explosionAnnim == 1:
		if explosion_finished:
			resetButton.show()
			MenueExplosion.show()  
