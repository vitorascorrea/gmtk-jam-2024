extends Node

const START_SCREEN_SCENE = "res://screens/start_screen.tscn"
const SCENE_TRANSITION_UI_SCENE = "res://globals/scene_transition_ui.tscn"

const MAX_SCALE = 4
const CHILD_COUNT_SCALES = {
	1: 1,
	2: 50,
	3: 150,
	4: 600,
	5: 900
}

const SCENES_PER_SCALES = {
	1: preload("res://entities/scale_one_colliders/scale_one_collider.tscn"),
	2: preload("res://entities/scale_two_colliders/scale_two_collider.tscn"),
	3: preload("res://entities/scale_three_colliders/scale_three_collider.tscn"),
	4: preload("res://entities/scale_four_colliders/scale_four_collider.tscn"),
}

var current_child_count = 0
var current_scale = 1


func change_scale(new_scale: int):
	current_scale = new_scale
