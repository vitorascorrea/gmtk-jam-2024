class_name Collector extends Area2D

var child_counter_timer = Timer.new()
var current_child_count: int = 1
var child_count_ratio_to_increase_area: float = 15.0
var area_radius_increment: float = 0.1

signal initial_destroyed


func _ready() -> void:
	$Core.set_owned()
	$Core.set_as_core()
	GlobalVariables.current_child_count = 1
	

func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click"):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + 90, 0.5)
	if Input.is_action_just_pressed("right_click"):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees - 90, 0.5)


func _on_initial_pixel_tree_exited() -> void:
	initial_destroyed.emit()
