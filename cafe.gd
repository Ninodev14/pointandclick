extends Area2D

@onready var area_to_show = $"../Marteau"
var button_sequence: Array = []
var correct_sequence: Array = ["C", "F", "A"]

func _ready() -> void:
	# Cache l'Area2D au départ
	area_to_show.visible = false
	
	# Connecte les signaux des boutons
	$C.pressed.connect(_on_ButtonC_pressed)
	$F.pressed.connect(_on_ButtonF_pressed)
	$A.pressed.connect(_on_ButtonA_pressed)

# Appelé lorsque le bouton C est pressé
func _on_ButtonC_pressed() -> void:
	_add_to_sequence("C")

# Appelé lorsque le bouton F est pressé
func _on_ButtonF_pressed() -> void:
	_add_to_sequence("F")

# Appelé lorsque le bouton A est pressé
func _on_ButtonA_pressed() -> void:
	_add_to_sequence("A")

# Ajoute un bouton à la séquence et vérifie si elle est correcte
func _add_to_sequence(button_name: String) -> void:
	button_sequence.append(button_name)
	if button_sequence == correct_sequence:
		_show_area()				
		var digicode = $"../Digicode"
		if digicode:
			digicode.visible = false
			
		var btn_gamma = $"../btnGamma"
		if btn_gamma:
			btn_gamma.visible = false 
			
		var simon = $"../Simone"
		if simon:
			simon.visible = false 
				
	elif button_sequence.size() > correct_sequence.size() or button_sequence[-1] != correct_sequence[button_sequence.size() - 1]:
		# Réinitialiser si la séquence est incorrecte
		button_sequence.clear()

# Affiche l'Area2D
func _show_area() -> void:
	area_to_show.visible = true
