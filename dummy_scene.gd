extends Node2D

var pixel_scene = preload("res://entities/pixels/pixel.tscn")
var destroyer_scene = preload("res://entities/destroyer/destroyer.tscn")
var pixel_spawn_timer = Timer.new()
var camera_zoom: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pixel_spawn_timer.wait_time = 0.1
	pixel_spawn_timer.autostart = true
	pixel_spawn_timer.connect("timeout", _on_pixel_spawn_timer_timeout)
	add_child(pixel_spawn_timer)
	
	$Collector.connect("child_counted", _on_child_counter_timer_timeout)


func _on_pixel_spawn_timer_timeout():
	if randf() < 0.1:
		var destroyer = destroyer_scene.instantiate()
		destroyer.position = Vector2(320, randi_range(20, 170))
		add_child(destroyer)
	else:
		var pixel = pixel_scene.instantiate()
		pixel.position = Vector2(320, randi_range(20, 170))
		add_child(pixel)


func _on_child_counter_timer_timeout(child_count: int):
	if child_count <= 1:
		$CanvasLayer/PauseMenu.set_label_message("Game over")
		$CanvasLayer/PauseMenu.trigger()
		return
	elif child_count > 100 and camera_zoom != 0.5:
		camera_zoom = 0.5
		var tween = get_tree().create_tween()
		tween.tween_property($Camera2D, "zoom", Vector2(camera_zoom, camera_zoom), 1)
