extends Area2D

# Dictionnaire pour stocker les valeurs des boutons
var typeBtn =  0
var button_values = {
	"Digicodebtn1": 0,
	"Digicodebtn2": 0,
	"Digicodebtn3": 0
}

# Référence au sprite
var my_sprite: Sprite2D
var Area2d: Area2D

# Variable pour savoir si le code est correct
var code_correct: bool = false

var entered_code: String = ""
var code_changed: bool = false 

# Appelé lorsqu'un bouton est pressé
func _on_Button_pressed(button_name: String) -> void:
	if button_values[button_name] < 9:
		button_values[button_name] += 1
	else:
		button_values[button_name] = 0 

	update_button_animation(button_name)

	# Vérifiez si le code est correct
	if button_values["Digicodebtn1"] == 1 and button_values["Digicodebtn2"] == 6 and button_values["Digicodebtn3"] == 3:
		code_changed = false 
		code_correct = true  
		typeBtn =  0 
		wait_and_show_sprite()  # Attendez 1 seconde avant d'afficher le sprite
	elif button_values["Digicodebtn1"] == 3 and button_values["Digicodebtn2"] == 1 and button_values["Digicodebtn3"] == 2:
		code_changed = false 
		code_correct = true  
		typeBtn =  1
		wait_and_show_sprite()  
	else:
		code_correct = false  # Le code n'est pas correct
		code_changed = true  # Le code a changé

# Met à jour l'animation du bouton
func update_button_animation(button_name: String) -> void:
	# Récupère le chemin du AnimatedSprite2D en fonction du bouton
	var animated_sprite = get_node(button_name + "/" + button_name + "AnimatedSprite2D")
	animated_sprite.play(str(button_values[button_name]))  # Joue l'animation correspondant à la valeur actuelle

func wait_and_show_sprite() -> void:
	var delay_timer = Timer.new()
	delay_timer.wait_time = 1.0 
	delay_timer.one_shot = true 
	delay_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(delay_timer)
	delay_timer.start()

func _on_Timer_timeout() -> void:
	if not code_changed:  # Vérifiez si le code a changé
		show_sprite()  # Affiche le sprite

# Affiche le sprite
func show_sprite() -> void:
	if typeBtn ==  0 :
		Area2d.visible = true
	else:
		my_sprite.visible = true

# Appel de la fonction lors du clic sur les boutons
func _ready() -> void:
	Area2d = $"../btnGamma"
	my_sprite = $"../Loose2"  # Assurez-vous que le nom correspond à celui de votre Sprite dans la scène
	
	# Initialiser le sprite comme invisible
	my_sprite.visible = false

	# Connecter les boutons aux fonctions
	$Digicodebtn1.pressed.connect(Callable(self, "_on_Button_pressed").bind("Digicodebtn1"))
	$Digicodebtn2.pressed.connect(Callable(self, "_on_Button_pressed").bind("Digicodebtn2"))
	$Digicodebtn3.pressed.connect(Callable(self, "_on_Button_pressed").bind("Digicodebtn3"))
