extends Node2D

@export var grid_size: int = 8 
@export var initial_cells_to_reveal: Array[Vector2i] = [
	Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(0, 3), Vector2i(0, 4)
]

var bomb_positions: Array[Vector2i] = []
var grid_cells: Array = []
var current_cell_position: Vector2i

@onready var timer = Timer.new()
@onready var element_to_keep = $NoteContener/Note
@onready var label = $TimerLabel
@onready var reset_button = $ResetButton
@onready var reveal_button = $RevealButton
@onready var flag_button = $FlagButton
@onready var pause_button: Button = $UI/Pause
@onready var pause_menu = $PauseMenu
@onready var resume_button: Button = $PauseMenu/Reprendre
@onready var settings_button: Button = $PauseMenu/Parametres
@onready var settings_menu = $SettingsMenu
@onready var back_button: Button = $SettingsMenu/Retour
@onready var pause_on_notes_checkbox: CheckBox = $SettingsMenu/ReadNoteTimerCheck # Référence à la checkbox

@onready var music_player: AudioStreamPlayer2D = $SonMenu
@onready var sfx_players: Array = [$btn_loose1/btnSound, $btnSound2]

var is_paused: bool = false
var remaining_time: float = 0

func _ready() -> void:
	music_player.play()
	create_grid()
	add_child(timer)
	timer.wait_time = 60
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

	reset_button.connect("pressed", Callable(self, "_on_reset_button_pressed"))
	reset_button.disabled = false
	_restore_element_data()
	set_process(true)

	place_bombs() 
	reveal_initial_cells()

	reveal_button.text = "Révéler"
	flag_button.text = "Drapeau"

	reveal_button.visible = false
	flag_button.visible = false

	reveal_button.connect("pressed", Callable(self, "_on_reveal_button_pressed"))
	flag_button.connect("pressed", Callable(self, "_on_flag_button_pressed"))
	pause_button.connect("pressed", Callable(self, "_on_pause_button_pressed"))
	resume_button.connect("pressed", Callable(self, "_on_resume_button_pressed"))
	settings_button.connect("pressed", Callable(self, "_on_settings_button_pressed"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))

	pause_menu.hide()
	settings_menu.hide()

	update_audio_volume()

#------------------------------- DEMINEUR ------------------------------------

func create_grid():
	var grid = $GridContainer
	grid.columns = grid_size  
	for x in range(grid_size):
		var row = []
		for y in range(grid_size):
			var button = Button.new()
			button.custom_minimum_size = Vector2(32, 32)  # Taille des boutons
			button.connect("pressed", Callable(self, "_on_cell_pressed").bind(Vector2i(x, y)))
			grid.add_child(button)
			row.append(button)
		grid_cells.append(row)

func place_bombs():
	var pattern = [
		[false, false, false, false, false, false, false, false],  # Ligne 0
		[false, false, true, true, true, false, false, false],  # Ligne 1
		[false, false, true, false, false, true, false, false],  # Ligne 2
		[false, false, true, false, false, true, false, false],  # Ligne 3
		[false, false, true, true, true, false, false, false],  # Ligne 4
		[false, false, true, false, false, false, false, false],  # Ligne 5
		[false, false, true, false, false, false, false, false],  # Ligne 6
		[false, false, true, false, false, false, false, false]   # Ligne 7
	]
	
	for x in range(grid_size):
		for y in range(grid_size):
			if pattern[x][y]:
				bomb_positions.append(Vector2i(x, y))

func reveal_initial_cells():
	for pos in initial_cells_to_reveal:
		reveal_cell(pos)

func _on_cell_pressed(position: Vector2i):
	current_cell_position = position
	var button_size = Vector2(32, 32)
	var clicked_button = grid_cells[position.x][position.y]
	var button_position = clicked_button.get_global_transform().origin
	reveal_button.position = button_position + Vector2(0, button_size.y + 10)
	flag_button.position = button_position + Vector2(button_size.x + 10, button_size.y + 10)
	reveal_button.visible = true
	flag_button.visible = true

func _on_reveal_button_pressed() -> void:
	reveal_button.visible = false
	flag_button.visible = false
	reveal_cell(current_cell_position)

func _on_flag_button_pressed() -> void:
	reveal_button.visible = false
	flag_button.visible = false
	place_flag(current_cell_position)

func hide_bombs():
	for pos in bomb_positions:
		grid_cells[pos.x][pos.y].text = ""

func count_adjacent_bombs(position: Vector2i) -> int:
	var count = 0
	for dx in range(-1, 2):
		for dy in range(-1, 2):
			var new_pos = position + Vector2i(dx, dy)
			if new_pos in bomb_positions:
				count += 1
	return count

func reveal_cell(position: Vector2i):
	if position in bomb_positions:
		grid_cells[position.x][position.y].text = "💣"
		print("Game Over!")
		reveal_bombs()
	else:
		var adjacent_bomb_count = count_adjacent_bombs(position)
		grid_cells[position.x][position.y].text = str(adjacent_bomb_count)

func place_flag(position: Vector2i) -> void:
	grid_cells[position.x][position.y].text = "🚩"

func reveal_bombs():
	for pos in bomb_positions:
		grid_cells[pos.x][pos.y].text = "💣"

#------------------------------- TIMER ------------------------------------

func _process(delta: float) -> void:
	if not is_paused and not timer.is_stopped():
		var time_left = int(timer.time_left)
		label.text = str(time_left) + " s restantes"

func _on_timer_timeout() -> void:
	_save_element_data()
	reset_button.disabled = false

func _save_element_data() -> void:
	Manageur.saved_text = element_to_keep.text

func _restore_element_data() -> void:
	element_to_keep.text = Manageur.saved_text

func _on_reset_button_pressed() -> void:
	_save_element_data()
	get_tree().reload_current_scene()
	call_deferred("_restore_element_data")
	reset_button.disabled = true

#------------------------------- PAUSE ------------------------------------

func _on_pause_button_pressed() -> void:
	if is_paused:
		timer.wait_time = remaining_time
		timer.start()
		is_paused = false
		pause_menu.hide()
	else:
		remaining_time = timer.time_left
		timer.stop()
		is_paused = true
		pause_menu.show()

func pause_timer() -> void:
	if pause_on_notes_checkbox.is_pressed(): 
		remaining_time = timer.time_left
		timer.stop()
		is_paused = true

func resume_timer() -> void:
	if pause_on_notes_checkbox.is_pressed():
		timer.wait_time = remaining_time
		timer.start()
		is_paused = false

func _on_resume_button_pressed() -> void:
	if is_paused:
		timer.wait_time = remaining_time
		timer.start()
		is_paused = false
		pause_menu.hide()

func _on_settings_button_pressed() -> void:
	pause_menu.hide()
	settings_menu.show()

	var music_slider: HSlider = settings_menu.get_node("MusicSlider")
	var sfx_slider: HSlider = settings_menu.get_node("SFXSlider")

	if music_slider and sfx_slider:
		music_slider.value = Manageur.music_volume * 100 
		sfx_slider.value = Manageur.sfx_volume * 100

		music_slider.connect("value_changed", Callable(self, "_on_music_slider_changed"))
		sfx_slider.connect("value_changed", Callable(self, "_on_sfx_slider_changed"))

func _on_back_button_pressed() -> void:
	settings_menu.hide()
	pause_menu.show()

#------------------------------- AUDIO ------------------------------------

func update_audio_volume() -> void:
	music_player.volume_db = linear_to_db(Manageur.music_volume)
	for player in sfx_players:
		if player:
			player.volume_db = linear_to_db(Manageur.sfx_volume)

func _on_music_slider_changed(value: float) -> void:
	Manageur.music_volume = value / 100.0
	update_audio_volume()

func _on_sfx_slider_changed(value: float) -> void:
	Manageur.sfx_volume = value / 100.0
	update_audio_volume()
