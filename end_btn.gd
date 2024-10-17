extends Area2D

@onready var btn_anim = $Button/btnAnnimGdend
@onready var main_scene = $"../MainScene"
@onready var mainMenue = $"../MainMenu"
@onready var GoodEnd = $"../MenueGoodEnd"
@onready var Noclick = $"../NoClick"

var is_pressed_animation_playing: bool = false

func _ready() -> void:
	GoodEnd.hide()
	mainMenue.hide()
	$Button.pressed.connect(_on_Button_pressed)
	btn_anim.animation_finished.connect(_on_Animation_finished)

	main_scene.animation_finished.connect(_on_MainScene_animation_finished)


func _on_Button_pressed() -> void:
	btn_anim.play("pressed")
	main_scene.play("victoire") 
	is_pressed_animation_playing = true
	Noclick.show()

func _on_Animation_finished() -> void:
	pass

func _on_MainScene_animation_finished() -> void:
	if is_pressed_animation_playing:
		mainMenue.show()
		GoodEnd.show() 
		is_pressed_animation_playing = false

func _process(delta: float) -> void:
	pass
