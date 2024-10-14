extends Node2D

@onready var btn1: Button = $btnGamma1
@onready var btn2: Button = $btnGamma2
@onready var btn3: Button = $btnGamma3

@onready var anim_player1: AnimatedSprite2D = $btnGamma1/btnGammaAnnim
@onready var anim_player2: AnimatedSprite2D = $btnGamma2/btnGammaAnnim
@onready var anim_player3: AnimatedSprite2D = $btnGamma3/btnGammaAnnim

# Sprites pour afficher les images
var loose3_sprite: Sprite2D
var loose4_sprite: Sprite2D
var loose5_sprite: Sprite2D

# Nouvelle Area2D à afficher
var new_area: Node2D

# Variables pour suivre l'état des boutons
var is_btn1_on: bool = false
var is_btn2_on: bool = false
var is_btn3_on: bool = false

# Ordre correct des boutons pour débloquer l'Area2D
var correct_sequence: Array = [3, 1, 2]
var current_sequence: Array = []  # Séquence actuelle cliquée par l'utilisateur

# Séquences qui déclenchent une réinitialisation
var reset_sequences: Array = [
	[3, 1, 1],
	[3, 1, 3],
	[3, 3]
]

# Séquences pour afficher des images spécifiques
var image_sequences: Dictionary

func _ready() -> void:
	# Initialisation des sprites ici après que la scène ait été chargée
	loose3_sprite = $"../Loose3"
	loose4_sprite = $"../Loose4"
	loose5_sprite = $"../Loose5"
	
	# Vérifie si les sprites existent et sont correctement référencés
	if loose3_sprite == null or loose4_sprite == null or loose5_sprite == null:
		print("Erreur: un ou plusieurs sprites sont introuvables.")
		return  # Arrête la fonction si un sprite est manquant

	# Masquer les images au démarrage
	loose3_sprite.visible = false
	loose4_sprite.visible = false
	loose5_sprite.visible = false

	btn1.connect("pressed", Callable(self, "_on_btn1_pressed"))
	btn2.connect("pressed", Callable(self, "_on_btn2_pressed"))
	btn3.connect("pressed", Callable(self, "_on_btn3_pressed"))

	# Initialisation de new_area ici après que la scène ait été chargée
	new_area = $"../Simone"
	if new_area != null:
		new_area.visible = false  # Masquer l'Area2D au départ
	else:
		print("Erreur: new_area est introuvable.")

	# Associer les séquences aux sprites d'images
	image_sequences = {
		[1]: loose3_sprite,  # Sprite à afficher pour séquence [1]
		[2]: loose4_sprite,  # Sprite à afficher pour séquence [2]
		[3, 2]: loose5_sprite  # Sprite à afficher pour séquence [3, 2]
	}

func _on_btn1_pressed() -> void:
	# Basculer l'animation du bouton 1
	if is_btn1_on:
		anim_player1.play("Off")
	else:
		anim_player1.play("On")
	is_btn1_on = !is_btn1_on
	
	# Ajouter le bouton à la séquence actuelle
	_add_to_sequence(1)

func _on_btn2_pressed() -> void:
	# Basculer l'animation du bouton 2
	if is_btn2_on:
		anim_player2.play("Off")
	else:
		anim_player2.play("On")
	is_btn2_on = !is_btn2_on
	
	# Ajouter le bouton à la séquence actuelle
	_add_to_sequence(2)

func _on_btn3_pressed() -> void:
	# Basculer l'animation du bouton 3
	if is_btn3_on:
		anim_player3.play("Off")
	else:
		anim_player3.play("On")
	is_btn3_on = !is_btn3_on
	
	# Ajouter le bouton à la séquence actuelle
	_add_to_sequence(3)

# Fonction pour ajouter un bouton à la séquence cliquée
func _add_to_sequence(button_number: int) -> void:
	current_sequence.append(button_number)

	# Vérifier si la séquence correspond à une séquence de réinitialisation
	if _check_reset_sequences():
		_reset_all()
		return  # Quitte la fonction si réinitialisé

	# Vérifier si la séquence a le même nombre d'éléments que la séquence correcte
	elif current_sequence.size() == correct_sequence.size():
		# Si la séquence est correcte
		if current_sequence == correct_sequence:
			_show_new_area()
		# Si la séquence est incorrecte, on réinitialise la séquence
		else:
			current_sequence.clear()

	# Vérifier si la séquence actuelle correspond à l'une des séquences pour afficher une image
	_display_image_based_on_sequence()

# Fonction pour afficher la nouvelle Area2D
func _show_new_area() -> void:
	if new_area != null:
		new_area.visible = true
		print("Nouvelle Area2D affichée !")

# Fonction pour vérifier si la séquence actuelle doit déclencher une réinitialisation
func _check_reset_sequences() -> bool:
	for seq in reset_sequences:
		if current_sequence == seq:
			return true
	return false

# Fonction pour réinitialiser tous les boutons et animations
func _reset_all() -> void:
	# Réinitialiser les animations
	anim_player1.play("Off")
	anim_player2.play("Off")
	anim_player3.play("Off")
	
	# Réinitialiser les états des boutons
	is_btn1_on = false
	is_btn2_on = false
	is_btn3_on = false
	
	# Vider la séquence actuelle
	current_sequence.clear()

	# Masquer toutes les images
	if loose3_sprite != null: loose3_sprite.visible = false
	if loose4_sprite != null: loose4_sprite.visible = false
	if loose5_sprite != null: loose5_sprite.visible = false

	print("Séquence réinitialisée. Tous les boutons et animations sont revenus à l'état initial.")

# Fonction pour afficher une image en fonction de la séquence
func _display_image_based_on_sequence() -> void:
	# Masquer toutes les images avant d'afficher la nouvelle
	if loose3_sprite != null: loose3_sprite.visible = false
	if loose4_sprite != null: loose4_sprite.visible = false
	if loose5_sprite != null: loose5_sprite.visible = false

	# Vérifier si la séquence actuelle correspond à une séquence avec image
	if image_sequences.has(current_sequence):
		var sprite_to_show: Sprite2D = image_sequences[current_sequence]
		if sprite_to_show != null:
			sprite_to_show.visible = true  # Affiche l'image correspondante
			print("Image affichée pour la séquence: ", current_sequence)
