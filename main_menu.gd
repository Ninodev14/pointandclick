extends Button

var camera: Camera2D
var Menu: Vector2 = Vector2(1000, 0)

func _ready() -> void:
	camera = $"../Camera2D"
	# Connexion du signal pressed() du bouton à la méthode _on_Button_pressed
	self.pressed.connect(_on_Button_pressed)

# Fonction appelée lorsqu'on clique sur le bouton
func _on_Button_pressed() -> void:
	camera.position = Menu
	$"../GoodEnding".stop()
