extends Node2D

@onready var button_vert = $Vert
@onready var button_noir = $Noir
@onready var button_rouge = $Rouge
@onready var button_jaune = $Jaune
@onready var animation_player = $AnimatedSimons
@onready var lonely_animation_player =  $"../AnimatedLonely"
@onready var fax = $"../Fax" # Référence au nœud Fax
@onready var faxAnnim = $"../Fax/Fax"
@onready var poem_button = $"../Fax/PoemBtn" # Référence au bouton PoemBtn

var base_sequence = [0, 1, 2, 1, 0, 3] 
var player_input = []
var is_player_turn = false
var current_sequence = []

var animating_black = false

func _ready():
	start_new_round()

	button_vert.connect("pressed", Callable(self, "_on_ButtonVert_pressed"))
	button_noir.connect("pressed", Callable(self, "_on_ButtonNoir_pressed"))
	button_rouge.connect("pressed", Callable(self, "_on_ButtonRouge_pressed"))
	button_jaune.connect("pressed", Callable(self, "_on_ButtonJaune_pressed"))

	animating_black = true
	animate_black()

func animate_black():
	while animating_black:
		animation_player.play("noir")
		lonely_animation_player.play("noir")
		await get_tree().create_timer(2).timeout 
		animation_player.stop()
		lonely_animation_player.stop()
		await get_tree().create_timer(0.5).timeout 

func start_new_round():
	print("Nouvelle ronde!")
	player_input.clear()
	if current_sequence.size() < base_sequence.size():
		current_sequence.append(base_sequence[current_sequence.size()])
		print("Séquence actuelle: ", current_sequence)
	else:
		faxAnnim.play("Poem") 
		await get_tree().create_timer(0.5).timeout
		poem_button.show()
		return

	play_sequence()

func play_sequence():
	is_player_turn = false
	animating_black = false
	print("Début de la séquence")
	
	for index in current_sequence:
		match index:
			0: # noir
				animation_player.play("noir")
				lonely_animation_player.play("noir")
				await get_tree().create_timer(1).timeout
			1: # rouge
				animation_player.play("rouge")
				lonely_animation_player.play("rouge")
				await get_tree().create_timer(1).timeout
			2: # jaune
				animation_player.play("jaune")
				lonely_animation_player.play("jaune")
				await get_tree().create_timer(1).timeout
			3: # vert
				animation_player.play("vert")
				lonely_animation_player.play("vert") 
				await get_tree().create_timer(1).timeout

	print("Séquence terminée, tour du joueur")
	is_player_turn = true

func _on_ButtonVert_pressed():
	print("Button Vert pressed")
	if is_player_turn:
		print("Input valid: Vert")
		player_input.append(3)
		play_button_animation(3)

func _on_ButtonNoir_pressed():
	print("Button Noir pressed")
	if is_player_turn:
		print("Input valid: Noir")
		player_input.append(0)
		play_button_animation(0)
		
func _on_ButtonRouge_pressed():
	print("Button Rouge pressed")
	if is_player_turn:
		print("Input valid: Rouge")
		player_input.append(1)
		play_button_animation(1)

func _on_ButtonJaune_pressed():
	print("Button Jaune pressed")
	if is_player_turn:
		print("Input valid: Jaune")
		player_input.append(2)
		play_button_animation(2)

func play_button_animation(index):
	match index:
		0: # noir
			animation_player.play("noir")
			lonely_animation_player.play("noir")
		1: # rouge
			animation_player.play("rouge")
			lonely_animation_player.play("rouge")
		2: # jaune
			animation_player.play("jaune")
			lonely_animation_player.play("jaune")
		3: # vert
			animation_player.play("vert")
			lonely_animation_player.play("vert")

	await get_tree().create_timer(0.5).timeout

	check_input()

func check_input():
	print("Entrée du joueur: ", player_input)
	var correct = true
	for i in range(player_input.size()):
		if i >= current_sequence.size() or player_input[i] != current_sequence[i]:
			correct = false
			break

	if !correct:
		print("Erreur! Essayez encore.")
		start_new_round()
	elif player_input.size() == current_sequence.size():		

		start_new_round()
