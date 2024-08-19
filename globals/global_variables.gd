extends Node

# Screens and options
const START_SCREEN_SCENE = "res://screens/start_screen.tscn"
const SCENE_TRANSITION_UI_SCENE = "res://globals/scene_transition_ui.tscn"
var music_volume = 1
var sfx_volume = 1

# Game constants
const CHILD_COUNT_GOAL = 400
const MAX_SCALE = 4
const CHILD_COUNT_SCALES = {
	1: 1,
	2: 50,
	3: 150,
	4: 250,
	5: 9999
}

const SCENES_PER_SCALES = {
	1: preload("res://entities/scale_one_colliders/scale_one_collider.tscn"),
	2: preload("res://entities/scale_two_colliders/scale_two_collider.tscn"),
	3: preload("res://entities/scale_three_colliders/scale_three_collider.tscn"),
	4: preload("res://entities/scale_four_colliders/scale_four_collider.tscn"),
	5: preload("res://entities/scale_five_colliders/scale_five_collider.tscn"),
}

# Game variables
var current_child_count = 1
var current_scale = 1


func reset():
	current_child_count = 1
	current_scale = 1	


func change_scale(new_scale: int):
	current_scale = new_scale
