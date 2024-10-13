extends Area2D

# Dictionnaire pour stocker les valeurs des boutons
var button_values = {
	"Digicodebtn1": 0,
	"Digicodebtn2": 0,
	"Digicodebtn3": 0
}

# Référence au sprite
var my_sprite: Sprite2D

# Fonction pour gérer le clic sur un bouton
func _on_Button_pressed(button_name: String) -> void:
	# Incrémente la valeur ou réinitialise à 0 si elle atteint 9
	if button_values[button_name] < 9:
		button_values[button_name] += 1
	else:
		button_values[button_name] = 0  # Réinitialiser à 0 si 9 atteint

	update_button_text(button_name)
	check_sprite_visibility()  # Vérifiez si le sprite doit être affiché

# Fonction pour mettre à jour le texte du bouton
func update_button_text(button_name: String) -> void:
	var button = get_node(button_name)
	button.text = str(button_values[button_name])

# Vérifie si le sprite doit être affiché
func check_sprite_visibility() -> void:
	if button_values["Digicodebtn1"] == 1 and button_values["Digicodebtn2"] == 6 and button_values["Digicodebtn3"] == 3:
		my_sprite.visible = true  # Affiche le sprite
	else:
		my_sprite.visible = false  # Cache le sprite si les conditions ne sont pas remplies

# Appel de la fonction lors du clic sur les boutons
func _ready() -> void:
	# Récupérer le sprite
	my_sprite = $"../Loose2"  # Assurez-vous que le nom correspond à celui de votre Sprite dans la scène
	
	# Initialiser le sprite comme invisible
	my_sprite.visible = false

	# Connecter les boutons aux fonctions
	$Digicodebtn1.pressed.connect(_on_Button_pressed.bind("Digicodebtn1"))
	$Digicodebtn2.pressed.connect(_on_Button_pressed.bind("Digicodebtn2"))
	$Digicodebtn3.pressed.connect(_on_Button_pressed.bind("Digicodebtn3"))
