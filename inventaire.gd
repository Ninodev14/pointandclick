extends Node2D

# Variables globales
var sequence = []  # La séquence complète
var player_input = []  # L'entrée du joueur
var colors = []  # Les objets ColorRect correspondant aux couleurs
var original_colors = []  # Les couleurs d'origine des ColorRect
var current_color_index = 0  # Indice de la couleur actuellement montrée dans la séquence
var current_round = 1  # Nombre de couleurs à montrer pour cette manche

# Séquence prédéfinie : orange, bleu, vert, orange, rose, bleu
var predefined_sequence = [0, 3, 1, 0, 2, 3]  # Correspond à l'ordre: orange, bleu, vert, orange, rose, bleu

func _ready():
	# Initialisation des boutons de couleur
	colors = [$orange, $Vert, $Rose, $Blue]  # S'assurer que l'ordre correspond aux indices
	# Stocker les couleurs d'origine
	for color in colors:
		original_colors.append(color.modulate)

	# Initialiser la séquence
	sequence = predefined_sequence.duplicate()  # Dupliquer la séquence prédéfinie pour l'utiliser dans le jeu

	start_new_round()  # Démarre le jeu

# Démarre une nouvelle manche en augmentant le nombre de couleurs à montrer
func start_new_round():
	player_input.clear()  # Réinitialise les entrées du joueur
	current_color_index = 0  # Réinitialise l'indice de la séquence
	show_sequence()  # Montre la séquence actuelle

# Affiche la séquence jusqu'à `current_round`, c'est-à-dire un nombre croissant de couleurs
func show_sequence():
	for i in range(current_round):
		# Illumine la couleur
		var color_to_show = sequence[i]
		colors[color_to_show].modulate = Color(2, 2, 2)  # Change temporairement la couleur en blanc
		await get_tree().create_timer(0.5).timeout  # Attend 0.5 secondes avant d'éteindre la couleur
		# Retourne à la couleur d'origine
		colors[color_to_show].modulate = original_colors[color_to_show]
		# Attendre avant de passer à la prochaine couleur
		await get_tree().create_timer(0.5).timeout  # Petite pause avant la couleur suivante

	# Après avoir montré la séquence, attendre que le joueur la reproduise
	print("Joueur, c'est à toi de jouer !")

# Gère l'entrée utilisateur sur chaque bouton ColorRect
func _handle_color_click(color_index):
	if current_color_index < current_round and color_index == sequence[current_color_index]:
		# Le joueur a cliqué sur la bonne couleur
		player_input.append(color_index)  # Ajoute l'index de la couleur cliquée par l'utilisateur
		current_color_index += 1  # Passe à la couleur suivante
		if current_color_index == current_round:
			# Le joueur a réussi à reproduire toute la séquence pour ce round
			print("Séquence correcte !")
			if current_round < sequence.size():
				current_round += 1  # Augmente le nombre de couleurs à montrer pour le prochain tour
				await get_tree().create_timer(1).timeout  # Pause avant de montrer la séquence suivante
				start_new_round()  # Recommence avec une séquence plus longue
			else:
				print("Bravo, tu as fini toute la séquence !")
		else:
			# Attendre que le joueur appuie sur la couleur suivante
			pass
	else:
		# Si le joueur a cliqué sur la mauvaise couleur
		print("Mauvaise séquence ! Game Over.")
		await get_tree().create_timer(1).timeout  # Petite pause avant de recommencer
		current_round = 1  # Recommencer à la première séquence
		start_new_round()

# Gère les événements pour chaque bouton ColorRect
func _on_orange_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(0)  # 0 pour Orange

func _on_vert_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(1)  # 1 pour Vert

func _on_rose_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(2)  # 2 pour Rose

func _on_blue_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(3)  # 3 pour Bleu
