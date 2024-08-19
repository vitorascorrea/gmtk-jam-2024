extends Node2D

var max_bar_size = 74
var child_counter_timer = Timer.new()

func _ready() -> void:
	child_counter_timer.wait_time = 0.2
	child_counter_timer.autostart = true
	child_counter_timer.connect("timeout", _on_child_counted)
	add_child(child_counter_timer)


func _on_child_counted():
	var progress_percentage = float(GlobalVariables.current_child_count) / float(GlobalVariables.CHILD_COUNT_GOAL)
	var tween = create_tween()
	tween.tween_property($ColorRect, "size:x", max_bar_size * progress_percentage, 0.5)
