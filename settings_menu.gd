extends ColorRect

@onready var music_volume_slider: HSlider = $MusicSlider 
@onready var sfx_volume_slider: HSlider = $SFXSlider 
@onready var back_button: Button = $Retour

func _ready() -> void:
	music_volume_slider.value = Manageur.music_volume * 100
	sfx_volume_slider.value = Manageur.sfx_volume * 100

	music_volume_slider.connect("value_changed", Callable(self, "_on_music_volume_slider_changed"))
	sfx_volume_slider.connect("value_changed", Callable(self, "_on_sfx_volume_slider_changed"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))

func _on_music_volume_slider_changed(value: float) -> void:
	var new_music_volume = value / 100.0
	Manageur.set_music_volume(new_music_volume)

func _on_sfx_volume_slider_changed(value: float) -> void:

	var new_sfx_volume = value / 100.0 
	Manageur.set_sfx_volume(new_sfx_volume)

func _on_back_button_pressed() -> void:
	hide()
	get_parent().get_node("PauseMenu").show()
