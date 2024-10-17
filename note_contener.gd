extends Area2D

# Variable pour l'Area2D à cacher
@onready var target_area: Area2D = $"."

# Appelée lorsque la scène est prête
func _ready() -> void:
	# Connecte le signal 'pressed()' du bouton au bouton_pressed() en utilisant Callable
	$OutNote.connect("pressed", Callable(self, "_on_OutNote_pressed"))

# Appelée lorsque le bouton est appuyé
func _on_OutNote_pressed() -> void:
	# Cache l'Area2D cible
	target_area.hide()

# Appelée à chaque frame (inutile dans ce cas, mais pour info)
func _process(delta: float) -> void:
	pass
