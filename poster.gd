extends Area2D

@onready var btnEnrouler = $AfficheEnrouler
@onready var btnDerouler = $AfficheDerouler
@onready var afficheAnim = $Affiche 

func _ready() -> void:
	btnEnrouler.connect("pressed", Callable(self, "_on_btn_enrouler_pressed"))
	btnDerouler.connect("pressed", Callable(self, "_on_btn_derouler_pressed"))

	btnDerouler.hide()

func _on_btn_enrouler_pressed() -> void:
	btnEnrouler.hide()
	print("Jouer l'animation Enrouler")
	afficheAnim.play("Enrouler")

	afficheAnim.connect("animation_finished", Callable(self, "_on_enrouler_finished"))

func _on_enrouler_finished() -> void:
	btnDerouler.show()
	afficheAnim.disconnect("animation_finished", Callable(self, "_on_enrouler_finished"))

func _on_btn_derouler_pressed() -> void:
	btnDerouler.hide()
	afficheAnim.play("Derouler")

	afficheAnim.connect("animation_finished", Callable(self, "_on_derouler_finished"))

func _on_derouler_finished() -> void:  
	print("Animation Derouler terminée") 
	btnEnrouler.show()
	afficheAnim.disconnect("animation_finished", Callable(self, "_on_derouler_finished"))
