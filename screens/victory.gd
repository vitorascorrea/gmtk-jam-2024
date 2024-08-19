extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tree().root.get_children():
		if child is Collector:
			child.reparent(self)
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	SceneTransition.transition_to("res://screens/start_screen.tscn")
