extends Node2D

@onready var btn1: Button = $btnGamma1
@onready var btn2: Button = $btnGamma2
@onready var btn3: Button = $btnGamma3

@onready var anim_player1: AnimatedSprite2D = $btnGamma1/btnGammaAnnim
@onready var anim_player2: AnimatedSprite2D = $btnGamma2/btnGammaAnnim
@onready var anim_player3: AnimatedSprite2D = $btnGamma3/btnGammaAnnim

@onready var main_scene_anim_player: AnimatedSprite2D = $"../MainScene"
@onready var reset = $"../ResetButton"
@onready var no_click = $"../NoClick"
@onready var simone: Node = $"../Simone"  # Référence à Simone

# Références aux AudioStreamPlayer pour jouer de la musique
@onready var music_thanos: AudioStreamPlayer = $"../FinThanos"
@onready var music_monstre: AudioStreamPlayer = $"../FinSatanique"
@onready var music_satanique: AudioStreamPlayer = $"../FinSatanique"

var is_btn1_on: bool = false
var is_btn2_on: bool = false
var is_btn3_on: bool = false

var correct_sequence: Array = [3, 1, 2]
var current_sequence: Array = []

var reset_sequences: Array = [
	[3, 1, 1],
	[3, 1, 3],
	[3, 3]
]

# Séquences pour lancer des animations spécifiques
var animation_sequences: Dictionary = {
	"1": "Thanos",    
	"2": "Monstre",   
	"3_2": "Satanique"  # Utilisation de "_" pour les combinaisons
}

func _ready() -> void:
	# Vérifie si le AnimatedSprite2D de la MainScene est bien référencé
	if main_scene_anim_player == null:
		print("Erreur: main_scene_anim_player est introuvable.")
		return  # Arrête la fonction si le AnimatedSprite2D est manquant

	no_click.visible = false
	simone.visible = false  # Assurez-vous que Simone est cachée au départ

	btn1.connect("pressed", Callable(self, "_on_btn1_pressed"))
	btn2.connect("pressed", Callable(self, "_on_btn2_pressed"))
	btn3.connect("pressed", Callable(self, "_on_btn3_pressed"))

	# Connecter le signal d'animation terminée
	main_scene_anim_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_btn1_pressed() -> void:
	if is_btn1_on:
		anim_player1.play("Off")
	else:
		anim_player1.play("On")
	is_btn1_on = !is_btn1_on

	_add_to_sequence(1)

func _on_btn2_pressed() -> void:
	if is_btn2_on:
		anim_player2.play("Off")
	else:
		anim_player2.play("On")
	is_btn2_on = !is_btn2_on

	_add_to_sequence(2)

func _on_btn3_pressed() -> void:
	if is_btn3_on:
		anim_player3.play("Off")
	else:
		anim_player3.play("On")
	is_btn3_on = !is_btn3_on

	_add_to_sequence(3)

func _add_to_sequence(button_number: int) -> void:
	current_sequence.append(button_number)

	# Conversion de current_sequence en clé de chaîne
	var key: String = str(current_sequence).replace(", ", "_").replace("[", "").replace("]", "")
	
	if _check_reset_sequences():
		_reset_all()
		return 

	elif current_sequence.size() == correct_sequence.size():
		if current_sequence == correct_sequence:
			_show_new_area()
		else:
			current_sequence.clear()

	_play_animation_based_on_sequence()

func _show_new_area() -> void:
	print("Nouvelle Area2D affichée !")
	simone.visible = true  # Rendre Simone visible

func _check_reset_sequences() -> bool:
	for seq in reset_sequences:
		if current_sequence == seq:
			return true
	return false

func _reset_all() -> void:
	anim_player1.play("Off")
	anim_player2.play("Off")
	anim_player3.play("Off")

	is_btn1_on = false
	is_btn2_on = false
	is_btn3_on = false

	current_sequence.clear()

	no_click.visible = false
	reset.visible = false

	print("Séquence réinitialisée. Tous les boutons et animations sont revenus à l'état initial.")

func _play_animation_based_on_sequence() -> void:
	var key: String = str(current_sequence).replace(", ", "_").replace("[", "").replace("]", "")
	
	if animation_sequences.has(key):
		var animation_to_play: String = animation_sequences[key]
		if animation_to_play != null and main_scene_anim_player != null:
			main_scene_anim_player.play(animation_to_play)
			no_click.visible = true

			# Jouer la musique appropriée en fonction de l'animation qui commence
			if animation_to_play == "Thanos":
				music_thanos.play()
			elif animation_to_play == "Monstre":
				music_monstre.play()
			elif animation_to_play == "Satanique":
				music_satanique.play()

			print("Animation jouée pour la séquence: ", current_sequence)

func _on_animation_finished() -> void:
	# Cette fonction est appelée lorsque l'animation se termine
	if main_scene_anim_player.animation == "Thanos":
		$"../MenueThanos".visible = true
		reset.visible = true
	elif main_scene_anim_player.animation == "Monstre":
		$"../MenueMonstre".visible = true
		reset.visible = true
	elif main_scene_anim_player.animation == "Satanique":
		$"../MenueSatanique".visible = true
		reset.visible = true
