extends Sprite2D

var is_dragging = false # state management
var mouse_offset # center mouse on click
var delay = .2
var drop_spots
var original_position = Vector2 (355, 244)# pour stocker la position d'origine

func _ready():
	drop_spots = get_tree().get_nodes_in_group("drop_spot_group")
	print(drop_spots)
	original_position = position # stocker la position d'origine du marteau

func _physics_process(delta):
	if is_dragging == true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position() - mouse_offset, delay * delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print('clicked on sprite')
				is_dragging = true
				mouse_offset = get_global_mouse_position() - global_position
		else:
			is_dragging = false
			var in_drop_spot = false
			
			# Vérifier si le marteau est dans un drop spot
			for drop_spot in drop_spots:
				if drop_spot.has_overlapping_areas() and drop_spot.get_overlapping_areas().has(self.get_node("Area2D")):
					in_drop_spot = true
					var snap_position = drop_spot.position
					var tween = get_tree().create_tween()
					tween.tween_property(self, "position", snap_position, delay)
					break # Sortir de la boucle si nous avons trouvé un drop spot

			# Si le marteau n'est pas dans un drop spot, le ramener à sa position d'origine
			if not in_drop_spot:
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", original_position, delay)
