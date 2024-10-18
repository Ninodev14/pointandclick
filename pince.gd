extends Area2D

var cannardAnnim = 0
var dragging = false
var offset = Vector2.ZERO
var last_area = null 
var initial_position = Vector2.ZERO 
var animation_playing = false  # Variable pour vérifier si une animation est en cours
@onready var CannardAnim = $"../MainScene"
@onready var MenueCannard = $"../MenueCanard" 
@onready var resetButton = $"../ResetButton"

# Ajout des musiques et menus supplémentaires
@onready var music_satanique: AudioStreamPlayer = $"../FinSatanique"
@onready var music_asteroid: AudioStreamPlayer = $"../FinSatanique"
@onready var MenueMIH = $"../MenueMIH"
@onready var MenueAsteroid = $"../MenueAsteroid"

func _ready() -> void:
	initial_position = position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			if self.get_global_mouse_position().distance_to(position) < 50:
				dragging = true
				offset = position - self.get_global_mouse_position()
		elif event.is_action_released("left_click"):
			dragging = false
			if last_area != null:
				_detect_color(last_area)
			else:
				_reset_position()

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() + offset

func _on_area_entered(area: Area2D) -> void:
	last_area = area

func _on_area_exited(area: Area2D) -> void:
	if last_area == area:
		last_area = null

func _detect_color(area: Area2D) -> void:
	if animation_playing:  # Si une animation est en cours, on ne fait rien
		return
	
	if area.is_in_group("Blanc"):
		_play_mih_animation()
		hide()
	elif area.is_in_group("Noir"):
		_play_asteroid_animation()
		hide()
	elif area.is_in_group("Cyan"):
		cannardAnnim = 1
		$"../CanrdV2Mp3".play()
		_play_cyan_animation()
		hide()
	elif area.is_in_group("Magenta"):
		print("La pince a touché le magenta!")
		hide()

# Fonction pour jouer l'animation MIH et la musique satanique lorsqu'on touche le blanc
func _play_mih_animation() -> void:
	if not CannardAnim.is_playing():  # Vérifier si une animation est déjà en cours
		animation_playing = true
		CannardAnim.play("MIH")
		music_satanique.play()  # Jouer la musique au début de l'animation
		CannardAnim.connect("animation_finished", Callable(self, "_on_mih_animation_finished"))

func _on_mih_animation_finished() -> void:
	animation_playing = false  # Animation terminée
	resetButton.show()
	MenueMIH.show()
	CannardAnim.disconnect("animation_finished", Callable(self, "_on_mih_animation_finished"))

# Fonction pour jouer l'animation Asteroid et la musique correspondante lorsqu'on touche le noir
func _play_asteroid_animation() -> void:
	if not CannardAnim.is_playing():  # Vérifier si une animation est déjà en cours
		animation_playing = true
		CannardAnim.play("Asteroid")
		music_asteroid.play()  # Jouer la musique au début de l'animation
		CannardAnim.connect("animation_finished", Callable(self, "_on_asteroid_animation_finished"))

func _on_asteroid_animation_finished() -> void:
	animation_playing = false  # Animation terminée
	resetButton.show()
	MenueAsteroid.show()
	CannardAnim.disconnect("animation_finished", Callable(self, "_on_asteroid_animation_finished"))

# Fonction pour jouer l'animation Canard lorsqu'on touche le cyan
func _play_cyan_animation() -> void:
	if not CannardAnim.is_playing():  # Vérifier si une animation est déjà en cours
		animation_playing = true
		CannardAnim.play("Canard")
		CannardAnim.connect("animation_finished", Callable(self, "_on_cyan_animation_finished"))

func _on_cyan_animation_finished() -> void:
	if cannardAnnim == 1:
		resetButton.show()
		MenueCannard.show()
	animation_playing = false  # Animation terminée
	CannardAnim.disconnect("animation_finished", Callable(self, "_on_cyan_animation_finished"))

func _reset_position() -> void:
	position = initial_position
