extends Node2D

@onready var Inventaire = $ObjetInventaire

func _input(event):
 if Input.is_action_just_pressed("Inventaire") and Inventaire.visible == false:
  Inventaire.show()
 elif Input.is_action_just_pressed("Inventaire") and Inventaire.visible == true:
  Inventaire.hide()


func _on_Areasortie_mouse_entered():
 if Inventaire.visible == true:
  Inventaire.hide()
