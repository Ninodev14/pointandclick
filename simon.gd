extends Node2D

var sequence = [] 
var player_input = []
var colors = []
var original_colors = []
var current_color_index = 0
var current_round = 1
var is_showing_sequence = false
var is_waiting_for_input = false  # Nouvelle variable d'état

# Séquence prédéfinie : orange, bleu, vert, orange, rose, bleu
var predefined_sequence = [2, 0, 1, 0, 2, 3]  # Correspond à l'ordre: orange, bleu, vert, orange, rose, bleu
var auto_timer = null  # Nouveau Timer pour relancer automatiquement la séquence

func _ready():
	colors = [$Orange, $Vert, $Rose, $Bleu]
	for color in colors:
		original_colors.append(color.modulate)
		
	sequence = predefined_sequence.duplicate()

	# Crée un Timer pour réactiver la première séquence toutes les 10 secondes
	auto_timer = Timer.new()
	auto_timer.wait_time = 10
	auto_timer.one_shot = false
	add_child(auto_timer)
	
	# Correction : connecte correctement le signal 'timeout' à la méthode '_on_auto_timer_timeout' avec Callable
	auto_timer.connect("timeout", Callable(self, "_on_auto_timer_timeout"))

	auto_timer.start()

	start_new_round()

# Cette fonction est appelée toutes les 10 secondes tant que le joueur n'a pas commencé à jouer
func _on_auto_timer_timeout():
	if not is_waiting_for_input:
		# Si le joueur n'a pas encore commencé à interagir, rejoue la séquence
		current_round = 1
		start_new_round()

func start_new_round():
	player_input.clear()
	current_color_index = 0
	show_sequence()

func show_sequence():
	is_showing_sequence = true  # Démarre la séquence
	is_waiting_for_input = false  # Bloque l'entrée pendant la séquence
	for i in range(current_round):
		var color_to_show = sequence[i]
		colors[color_to_show].modulate = Color(2, 2, 2)
		await get_tree().create_timer(0.2).timeout  # Attend 0.2 secondes avant d'éteindre la couleur
		colors[color_to_show].modulate = original_colors[color_to_show]
		await get_tree().create_timer(0.1).timeout  # Petite pause avant la couleur suivante
	is_showing_sequence = false  # Fin de la séquence
	is_waiting_for_input = true  # Permet l'entrée du joueur maintenant
	auto_timer.stop()  # Arrête le Timer une fois que le joueur peut interagir

func _handle_color_click(color_index):
	if is_showing_sequence or not is_waiting_for_input:
		return  # Ignore l'entrée si la séquence est en cours de présentation ou si l'entrée n'est pas permise
	
	if current_color_index < current_round and color_index == sequence[current_color_index]:
		player_input.append(color_index)
		current_color_index += 1
		if current_color_index == current_round:
			if current_round < sequence.size():
				current_round += 1
				await get_tree().create_timer(0.2).timeout  # Pause avant de montrer la séquence suivante
				start_new_round()
		else:
			pass
	else:
		# Si le joueur a cliqué sur la mauvaise couleur
		print("Mauvaise séquence ! Game Over.")
		await get_tree().create_timer(1).timeout  # Petite pause avant de recommencer
		current_round = 1
		auto_timer.start()  # Redémarre le Timer si le joueur perd
		start_new_round()

func _on_bleu_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(3)

func _on_orange_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(0)

func _on_vert_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(1)

func _on_rose_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(2)
