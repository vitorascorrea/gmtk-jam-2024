extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/MusicContainer/HSlider.value = GlobalVariables.music_volume
	$MarginContainer/VBoxContainer/SFXContainer/HSlider.value = GlobalVariables.sfx_volume
	$MarginContainer/VBoxContainer/DifficultyContainer/HSlider.value = GlobalVariables.difficulty_level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	SceneTransition.transition_to("res://screens/start_screen.tscn")


func _on_music_slider_drag_ended(value_changed: bool) -> void:
	GlobalVariables.music_volume = $MarginContainer/VBoxContainer/MusicContainer/HSlider.value
	
	$MusicAudioPlayer.refresh_volume()


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	GlobalVariables.sfx_volume = $MarginContainer/VBoxContainer/SFXContainer/HSlider.value


func _on_difficulty_drag_ended(value_changed: bool) -> void:
	GlobalVariables.difficulty_level = $MarginContainer/VBoxContainer/DifficultyContainer/HSlider.value
