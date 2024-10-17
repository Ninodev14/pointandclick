extends Button

var camera: Camera2D
var Menu: Vector2 = Vector2(1000, 0)

func _ready() -> void:
	camera = $"../../Camera2D"
	self.pressed.connect(_on_Button_pressed)

func _on_Button_pressed() -> void:
	camera.position = Menu
