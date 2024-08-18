class_name Collector extends Area2D

var child_counter_timer = Timer.new()
var current_child_count: int = 1
var child_count_ratio_to_increase_area: float = 15.0
var area_radius_increment: float = 0.1

signal child_counted


func _ready() -> void:	
	child_counter_timer.wait_time = 2.0
	child_counter_timer.autostart = true
	child_counter_timer.connect("timeout", _on_child_counter_timer_timeout)
	add_child(child_counter_timer)
	
	$InitialPixel.set_owned()
	

func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click"):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + 90, 0.5)
	if Input.is_action_just_pressed("right_click"):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees - 90, 0.5)


func _on_body_entered(body: Node2D) -> void:
	if body is BaseCollider and current_child_count >= body.min_size:
		body.set_owned()
		body.reparent(self)


func _on_child_counter_timer_timeout():
	# Removing the collision shape
	current_child_count = get_child_count() - 1
	GlobalVariables.current_child_count = current_child_count
	
	child_counted.emit(current_child_count)
	
	if current_child_count > child_count_ratio_to_increase_area:
		$CollisionShape2D.shape.radius += (
			(float(current_child_count) / child_count_ratio_to_increase_area) * area_radius_increment
		)
	else:
		$CollisionShape2D.shape.radius = 2
	
	print(current_child_count, " ", $CollisionShape2D.shape.radius)
