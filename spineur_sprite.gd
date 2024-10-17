extends Area2D

# Référence aux boutons et aux AnimatedSprite2D
@onready var btn_spincomp1 = $Spincomp1
@onready var btn_spincomp2 = $Spincomp2
@onready var btn_spincomp3 = $Spincomp3
@onready var btn_spincomp4 = $Spincomp4

@onready var sprite_spincomp1 = $Spincomp1/Spincomp1
@onready var sprite_spincomp2 = $Spincomp2/Spincomp2
@onready var sprite_spincomp3 = $Spincomp3/Spincomp3
@onready var sprite_spincomp4 = $Spincomp4/Spincomp4

# Référence au sprite d2 (qui sera affiché lorsque les conditions sont remplies)
@onready var sprite_d2 =  $"../Loose6"# Assure-toi que ce sprite est bien dans la scène

# Les états initiaux (ils commencent tous à 1)
var state_spincomp1 = 1
var state_spincomp2 = 1
var state_spincomp3 = 1
var state_spincomp4 = 1

# Indicateur pour savoir si l'animation est en cours
var is_playing_spincomp1 = false
var is_playing_spincomp2 = false
var is_playing_spincomp3 = false
var is_playing_spincomp4 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connexion des boutons aux fonctions avec Callable dans Godot 4
	btn_spincomp1.connect("pressed", Callable(self, "_on_spin_pressed").bind(1))
	btn_spincomp2.connect("pressed", Callable(self, "_on_spin_pressed").bind(2))
	btn_spincomp3.connect("pressed", Callable(self, "_on_spin_pressed").bind(3))
	btn_spincomp4.connect("pressed", Callable(self, "_on_spin_pressed").bind(4))

	# Connexion des signaux `animation_finished` pour détecter la fin des animations
	sprite_spincomp1.connect("animation_finished", Callable(self, "_on_animation_finished").bind(1))
	sprite_spincomp2.connect("animation_finished", Callable(self, "_on_animation_finished").bind(2))
	sprite_spincomp3.connect("animation_finished", Callable(self, "_on_animation_finished").bind(3))
	sprite_spincomp4.connect("animation_finished", Callable(self, "_on_animation_finished").bind(4))

	# Cacher le sprite d2 au début
	sprite_d2.visible = false

# Fonction pour gérer le clic avec un index
func _on_spin_pressed(comp_index: int) -> void:
	match comp_index:
		1:
			if not is_playing_spincomp1:
				state_spincomp1 += 1
				if state_spincomp1 > 4:
					state_spincomp1 = 1
				sprite_spincomp1.play("Etat" + str(state_spincomp1))
				is_playing_spincomp1 = true  # Animation en cours
		
		2:
			if not is_playing_spincomp2:
				state_spincomp2 += 1
				if state_spincomp2 > 4:
					state_spincomp2 = 1
				sprite_spincomp2.play("Etat" + str(state_spincomp2))
				is_playing_spincomp2 = true  # Animation en cours
		
		3:
			if not is_playing_spincomp3:
				state_spincomp3 += 1
				if state_spincomp3 > 4:
					state_spincomp3 = 1
				sprite_spincomp3.play("Etat" + str(state_spincomp3))
				is_playing_spincomp3 = true  # Animation en cours
		
		4:
			if not is_playing_spincomp4:
				state_spincomp4 += 1
				if state_spincomp4 > 4:
					state_spincomp4 = 1
				sprite_spincomp4.play("Etat" + str(state_spincomp4))
				is_playing_spincomp4 = true  # Animation en cours
	
	# Vérifie si les états sont satisfaits
	_check_conditions()

# Vérifie si les états correspondent aux conditions spécifiques
func _check_conditions() -> void:
	if state_spincomp1 == 2 and state_spincomp2 == 2 and state_spincomp3 == 1 and state_spincomp4 == 1:
		# Si les conditions sont remplies, affiche le sprite d2
		sprite_d2.visible = true
	else:
		# Sinon, masque le sprite d2
		sprite_d2.visible = false

# Fonction appelée lorsque l'animation se termine
func _on_animation_finished(comp_index: int) -> void:
	match comp_index:
		1:
			is_playing_spincomp1 = false
		2:
			is_playing_spincomp2 = false
		3:
			is_playing_spincomp3 = false
		4:
			is_playing_spincomp4 = false
