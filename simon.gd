extends Node2D

var sequence = [] 
var player_input = []
var colors = []
var original_colors = []
var current_color_index = 0
var current_round = 1
var is_showing_sequence = false
var is_waiting_for_input = false

var predefined_sequence = [2, 0, 1, 0, 2, 3]

var is_rose_flashing = true  # Variable to control the pink light flashing
var rose_flash_timer = null  # Timer reference for flashing

func _ready():
	colors = [$Orange, $Vert, $Rose, $Bleu]
	for color in colors:
		original_colors.append(color.modulate)

	sequence = predefined_sequence.duplicate()
	
	# Start the flashing of the pink light
	start_rose_flashing()

	start_new_round()

func start_new_round():
	player_input.clear()
	current_color_index = 0
	show_sequence()

func show_sequence() -> void:
	is_showing_sequence = true
	is_waiting_for_input = false
	for i in range(current_round):
		var color_to_show = sequence[i]
		colors[color_to_show].modulate = Color(2, 2, 2)
		await get_tree().create_timer(0.2).timeout
		colors[color_to_show].modulate = original_colors[color_to_show]
		await get_tree().create_timer(0.1).timeout
	is_showing_sequence = false
	is_waiting_for_input = true

# Function to handle color click and flashing
func _handle_color_click(color_index: int) -> void:
	if is_showing_sequence or not is_waiting_for_input:
		return
	
	# Change the color temporarily
	colors[color_index].modulate = Color(2, 2, 2)  # Make it brighter
	await get_tree().create_timer(0.2).timeout
	colors[color_index].modulate = original_colors[color_index]
	
	if current_color_index < current_round and color_index == sequence[current_color_index]:
		player_input.append(color_index)
		current_color_index += 1
		if current_color_index == current_round:
			if current_round < sequence.size():
				current_round += 1
				await get_tree().create_timer(0.2).timeout
				start_new_round()
			else:
				var digicode = $"../Digicode"
				if digicode:
					digicode.visible = false
			
				var btn_gamma = $"../btnGamma"
				if btn_gamma:
					btn_gamma.visible = false 
				
				var simon = $"."
				if simon:
					simon.visible = false 
				# Jouer l'animation Poem
				var animation_player = $"../Fax/Fax"
				if animation_player:  # Vérifier si l'animation player existe
					animation_player.play("Poem")  # Lancez l'animation Poem
				
					# Attendre que l'animation se termine
					while animation_player.is_playing():
						await get_tree().create_timer(0.1).timeout
				
					# Afficher le bouton après l'animation
					var poem_btn = $"../Fax/PoemBtn"
					if poem_btn:
						poem_btn.visible = true

		else:
			pass
	else:
		var loose_sprite = $"../Loose6" 
		loose_sprite.visible = true 

func start_rose_flashing() -> void:
	rose_flash_timer = Timer.new()
	rose_flash_timer.wait_time = 1.0
	rose_flash_timer.one_shot = false
	add_child(rose_flash_timer) 
	rose_flash_timer.start()

	flash_rose_periodically()

func flash_rose_periodically() -> void:
	while is_rose_flashing:
		await flash_rose()
		await rose_flash_timer.timeout  

func flash_rose() -> void:
	if is_rose_flashing:
		colors[2].modulate = Color(2, 2, 2) 
		await get_tree().create_timer(0.2).timeout
		colors[2].modulate = original_colors[2]

func _on_rose_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(2)
		if rose_flash_timer:
			is_rose_flashing = false
			rose_flash_timer.stop()
			if rose_flash_timer.get_parent() == self:
				remove_child(rose_flash_timer)

func _on_bleu_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(3)

func _on_orange_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(0)

func _on_vert_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		_handle_color_click(1)
