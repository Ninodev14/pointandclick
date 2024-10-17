extends AnimatedSprite2D

var Earthboom71 : Sprite2D
var EcranVille : Sprite2D
var EcranTd : Sprite2D
var EcranForet : Sprite2D
var EcranGlacier : Sprite2D
var EcranPeople : Sprite2D
var EcranTerre : Sprite2D
var MainScene : Sprite2D
var Zvesrvsr : Sprite2D

@onready var animatedSprite = $"."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Earthboom71 = $Earthboom71

	Earthboom71.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_changer_pressed() -> void:
	animatedSprite.play("changer")


func _on_revenir_pressed() -> void:
	animatedSprite.play("revenir")
