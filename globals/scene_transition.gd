extends Node

var scene_transition_ui_scene = preload(GlobalVariables.SCENE_TRANSITION_UI_SCENE)

func transition_to(file_name: String) -> void:
	get_tree().paused = true
	var scene_transition_ui = scene_transition_ui_scene.instantiate()
	get_tree().root.add_child(scene_transition_ui)
	
	await scene_transition_ui.fade_out()

	get_tree().change_scene_to_file.bind(file_name).call_deferred()
	await scene_transition_ui.fade_in()
	
	get_tree().paused = false
	scene_transition_ui.queue_free()
