class_name Idle extends State

@export var character: CharacterBody2D
@export var walking_state: State
@export var jumping_state: State


func enter():
	character.modulate = Color.BLACK


func exit():
	character.modulate = Color.WHITE


func physics_update(delta: float):
	if Input.is_action_just_pressed("ui_up"):		
		transitioned.emit(jumping_state)
		return

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		transitioned.emit(walking_state)
