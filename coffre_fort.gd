extends Area2D

var animations = ["a", "p", "u", "h", "b", "s"]
var currentAnimationIndex = 0
var isRestarting = false

func _ready() -> void:
	$coffreFortBtn.connect("pressed", Callable(self, "_on_Button_pressed"))
	$coffreFortValidationBtn.connect("pressed", Callable(self, "_on_ValidationButton_pressed"))
	$coffreFortBtn/coffreFortSprite.play(animations[currentAnimationIndex])

func _on_Button_pressed() -> void:
	if isRestarting:
		isRestarting = false
		currentAnimationIndex = 1 
		$coffreFortBtn/coffreFortSprite.play(animations[currentAnimationIndex])
		return

	currentAnimationIndex += 1

	if currentAnimationIndex >= animations.size():
		currentAnimationIndex = 0
		$coffreFortBtn/coffreFortSprite.play("restart")
		isRestarting = true 
	else:
		$coffreFortBtn/coffreFortSprite.play(animations[currentAnimationIndex])

func _on_ValidationButton_pressed() -> void:
	$coffreFortValidationBtn/coffreFortValidationSprite.play("press")

	if currentAnimationIndex == 1:
		$"../Pince".visible = true
	else:
		$"../Loose6".visible = true
