class_name StateMachine extends Node


@export var starting_state: State

var states: Array[State] = []
var current_state: State


func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.connect("transitioned", _on_state_transitioned)
	
	current_state = starting_state
	
	current_state.enter()


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _on_state_transitioned(new_state: State):
	current_state.exit()
	new_state.enter()
	
	current_state = new_state
