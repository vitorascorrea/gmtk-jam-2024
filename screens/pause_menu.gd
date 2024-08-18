class_name PauseMenu extends Control

var next_stage_enabled = false
var restart_enabled = true
var activable = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


func set_label_message(message: String):
	$VBoxContainer/Label.text = message


func trigger():
	if activable and is_instance_valid(get_tree()):
		get_tree().paused = true
		visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if activable and Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused


func _on_back_to_menu_button_pressed() -> void:
	activable = false
	SceneTransition.transition_to(GlobalVariables.START_SCREEN_SCENE)
