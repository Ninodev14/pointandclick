extends Area2D

@onready var btn_spincomp1 = $Spincomp1
@onready var btn_spincomp2 = $Spincomp2
@onready var btn_spincomp3 = $Spincomp3
@onready var btn_spincomp4 = $Spincomp4

@onready var sprite_spincomp1 = $Spincomp1/Spincomp1
@onready var sprite_spincomp2 = $Spincomp2/Spincomp2
@onready var sprite_spincomp3 = $Spincomp3/Spincomp3
@onready var sprite_spincomp4 = $Spincomp4/Spincomp4

@onready var sprite_spinend = $Spinend  # Référence au sprite Spinend

var state_spincomp1 = 1
var state_spincomp2 = 1
var state_spincomp3 = 1
var state_spincomp4 = 1

var is_playing_spincomp1 = false
var is_playing_spincomp2 = false
var is_playing_spincomp3 = false
var is_playing_spincomp4 = false

func _ready() -> void:
	btn_spincomp1.connect("pressed", Callable(self, "_on_spin_pressed").bind(1))
	btn_spincomp2.connect("pressed", Callable(self, "_on_spin_pressed").bind(2))
	btn_spincomp3.connect("pressed", Callable(self, "_on_spin_pressed").bind(3))
	btn_spincomp4.connect("pressed", Callable(self, "_on_spin_pressed").bind(4))

	sprite_spincomp1.connect("animation_finished", Callable(self, "_on_animation_finished").bind(1))
	sprite_spincomp2.connect("animation_finished", Callable(self, "_on_animation_finished").bind(2))
	sprite_spincomp3.connect("animation_finished", Callable(self, "_on_animation_finished").bind(3))
	sprite_spincomp4.connect("animation_finished", Callable(self, "_on_animation_finished").bind(4))

	sprite_spinend.visible = false  # Assurez-vous que Spinend est caché au départ

func _on_spin_pressed(comp_index: int) -> void:
	match comp_index:
		1:
			if not is_playing_spincomp1:
				state_spincomp1 += 1
				if state_spincomp1 > 4:
					state_spincomp1 = 1
				sprite_spincomp1.play("Etat" + str(state_spincomp1))
				is_playing_spincomp1 = true  
		
		2:
			if not is_playing_spincomp2:
				state_spincomp2 += 1
				if state_spincomp2 > 4:
					state_spincomp2 = 1
				sprite_spincomp2.play("Etat" + str(state_spincomp2))
				is_playing_spincomp2 = true 
		
		3:
			if not is_playing_spincomp3:
				state_spincomp3 += 1
				if state_spincomp3 > 4:
					state_spincomp3 = 1
				sprite_spincomp3.play("Etat" + str(state_spincomp3))
				is_playing_spincomp3 = true 
		
		4:
			if not is_playing_spincomp4:
				state_spincomp4 += 1
				if state_spincomp4 > 4:
					state_spincomp4 = 1
				sprite_spincomp4.play("Etat" + str(state_spincomp4))
				is_playing_spincomp4 = true  
	
	_check_conditions()

func _check_conditions() -> void:
	# Check if none of the animations are currently playing
	if is_playing_spincomp1 or is_playing_spincomp2 or is_playing_spincomp3 or is_playing_spincomp4:
		return  # Exit the function if any animation is still playing

	if state_spincomp1 == 2 and state_spincomp2 == 2 and state_spincomp3 == 1 and state_spincomp4 == 1:
		sprite_spinend.visible = true  # Afficher le sprite Spinend
		sprite_spinend.play("end")  # Jouer l'animation "End"
		_disable_buttons()  # Désactiver les boutons
	else:
		sprite_spinend.visible = false

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
	
	# Call _check_conditions after any animation finishes
	_check_conditions()

# Nouvelle fonction pour désactiver les boutons
func _disable_buttons() -> void:
	btn_spincomp1.disabled = true
	btn_spincomp2.disabled = true
	btn_spincomp3.disabled = true
	btn_spincomp4.disabled = true
