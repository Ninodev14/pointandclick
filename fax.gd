extends Area2D

# Références à vos nodes
@onready var poem_btn = $PoemBtn
@onready var poemZoom = $"../poemZoom"
@onready var poem_out = $"../poemZoom/PoemOut"  # Assurez-vous que PoemOut est un Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connecter le signal "pressed" du bouton PoemBtn à la méthode show_area
	poem_btn.pressed.connect(self._on_PoemBtn_pressed)
	# S'assurer que l'Area2D est cachée au départ
	poemZoom.hide()
	
	# Connecter le signal "pressed" pour PoemOut
	poem_out.pressed.connect(self._on_PoemOut_pressed)

# Méthode appelée lorsque le bouton PoemBtn est pressé
func _on_PoemBtn_pressed() -> void:
	# Montrer l'Area2D
	poemZoom.show()

# Méthode appelée lorsque le bouton PoemOut est pressé
func _on_PoemOut_pressed() -> void:
	# Cacher l'Area2D poemZoom
	poemZoom.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
