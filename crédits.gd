extends Control

var camera: Camera2D
var Menue: Vector2 = Vector2(1000, 0) 

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retour_crédits_pressed() -> void:
	camera.position = Menue
	get_tree().change_scene_to_file("res://menu_principal.tscn")
