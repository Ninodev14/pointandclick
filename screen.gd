extends Area2D

var letters = []
var filled_letter_count = 0  
var current_input = ""  
@onready var demnieur = $"../DemineurActiveur"
@onready var coffreFort = $"../coffreFort"
@onready var screen =  $"../screen"
@onready var cable =  $"../Cable"
@onready var spineur =  $"../SpineurSprite"
@onready var btn =  $"../btn_loose1"

func _ready() -> void:
	letters.append($Lettre1)
	letters.append($Lettre2)
	letters.append($Lettre3)
	letters.append($Lettre4)
	letters.append($Lettre5)
	letters.append($Lettre6)

	$U.connect("pressed", Callable(self, "_on_button_pressed").bind("U1"))
	$T.connect("pressed", Callable(self, "_on_button_pressed").bind("T1"))
	$N.connect("pressed", Callable(self, "_on_button_pressed").bind("N1"))
	$R.connect("pressed", Callable(self, "_on_button_pressed").bind("R1"))
	$C.connect("pressed", Callable(self, "_on_button_pressed").bind("C1"))
	$W.connect("pressed", Callable(self, "_on_button_pressed").bind("W1"))
	$L.connect("pressed", Callable(self, "_on_button_pressed").bind("L1"))
	$D.connect("pressed", Callable(self, "_on_button_pressed").bind("D1"))
	$E.connect("pressed", Callable(self, "_on_button_pressed").bind("E1"))
	$V.connect("pressed", Callable(self, "_on_button_pressed").bind("V1"))
	$B.connect("pressed", Callable(self, "_on_button_pressed").bind("B1"))
	$I.connect("pressed", Callable(self, "_on_button_pressed").bind("I1"))
	$P.connect("pressed", Callable(self, "_on_button_pressed").bind("P1"))
	$A.connect("pressed", Callable(self, "_on_button_pressed").bind("A1"))

	$BackDash.connect("pressed", Callable(self, "_on_backdash_pressed"))

	$Valider.connect("pressed", Callable(self, "_on_validate_pressed"))

	$"../endBtn".hide()

func _on_button_pressed(letter: String) -> void:

	if filled_letter_count < letters.size(): 
		letters[filled_letter_count].texture = load("res://Screen/letters/" + letter + ".png")
		current_input += letter.substr(0, 1) 
		filled_letter_count += 1 
		
func _on_backdash_pressed() -> void:
	if filled_letter_count > 0:
		filled_letter_count -= 1 
		letters[filled_letter_count].texture = null  
		current_input = current_input.substr(0, current_input.length() - 1)  

func _on_validate_pressed() -> void:
	if current_input == "WALLID": 
		$"../endBtn".show() 
		spineur.hide()
		cable.hide()
		screen.hide()
		coffreFort.hide()
		demnieur.hide()
		btn.hide()
	else:
		print("Code incorrect, réessayez.")
