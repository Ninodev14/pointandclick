extends ColorRect

@onready var music_volume_slider: HSlider = $MusicSlider  # Référence au Slider de volume de la musique
@onready var sfx_volume_slider: HSlider = $SFXSlider  # Référence au Slider de volume des SFX
@onready var back_button: Button = $Retour  # Référence au bouton "Retour"

func _ready() -> void:
	# Initialiser les curseurs de volume avec les valeurs actuelles
	music_volume_slider.value = Manageur.music_volume * 100  # Calculer le volume de la musique en pourcentage
	sfx_volume_slider.value = Manageur.sfx_volume * 100  # Calculer le volume des SFX en pourcentage

	# Connecter les signaux des curseurs pour changer le volume
	music_volume_slider.connect("value_changed", Callable(self, "_on_music_volume_slider_changed"))  # Connexion pour le volume de la musique
	sfx_volume_slider.connect("value_changed", Callable(self, "_on_sfx_volume_slider_changed"))  # Connexion pour le volume des SFX
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))  # Connexion du bouton "Retour"

func _on_music_volume_slider_changed(value: float) -> void:
	# Appliquer le volume de la musique
	var new_music_volume = value / 100.0  # Convertir en valeur entre 0.0 et 1.0
	Manageur.set_music_volume(new_music_volume)  # Ajuster le volume de la musique

	# Optionnel : Mettre à jour l'interface utilisateur si nécessaire
	# Vous pouvez afficher la valeur actuelle du volume de la musique ici, si nécessaire.

func _on_sfx_volume_slider_changed(value: float) -> void:
	# Appliquer le volume des SFX
	var new_sfx_volume = value / 100.0  # Convertir en valeur entre 0.0 et 1.0
	Manageur.set_sfx_volume(new_sfx_volume)  # Ajuster le volume des effets sonores

	# Optionnel : Mettre à jour l'interface utilisateur si nécessaire
	# Vous pouvez afficher la valeur actuelle du volume des SFX ici, si nécessaire.

func _on_back_button_pressed() -> void:
	# Masquer le menu des paramètres et revenir au menu de pause
	hide()
	get_parent().get_node("PauseMenu").show()  # Assurez-vous que "PauseMenu" est le nom du nœud parent du menu de pause
