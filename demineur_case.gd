extends Button

# Variables pour suivre l'état de la case
var is_bomb = false
var is_revealed = false
var adjacent_bombs = 0

# Fonction pour révéler la case
func reveal():
	if is_revealed:
		return
	is_revealed = true
	self.disabled = true  # Désactiver le bouton après avoir cliqué
	if is_bomb:
		text = "💣"  # Affiche une bombe
	elif adjacent_bombs > 0:
		text = str(adjacent_bombs)  # Affiche le nombre de bombes voisines

# Fonction appelée quand le bouton est pressé
func _on_button_pressed():
	reveal()

# Fonction pour définir si cette case est une bombe
func set_bomb():
	is_bomb = true
