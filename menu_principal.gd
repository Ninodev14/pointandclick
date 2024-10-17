extends Control

# Référence à la caméra
var camera: Camera2D


var Game: Vector2 = Vector2(0, 0) 
var Sucser: Vector2 = Vector2(3000, 0) 
var credit: Vector2 = Vector2(5000, 0) 

func _ready() -> void:
	camera = $"../Camera2D"

func _process(delta: float) -> void:
	pass

func _on_commencer_pressed() -> void:
	camera.position = Game
	Manageur.Startimer = 1


func _on_paramètre_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_succès_pressed() -> void:
	camera.position = Sucser

func _on_crédits_pressed() -> void:
	camera.position = credit

func _on_quitter_pressed() -> void:
	get_tree().quit()
