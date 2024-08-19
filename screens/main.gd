extends Node2D

var collider_factory = ColliderFactory.new()
var pixel_spawn_timer = Timer.new()
var child_counter_timer = Timer.new()

var last_child_count: int = 1
var current_scale: int = 1
const base_screen_dimensions: Vector2 = Vector2(320, 180)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	child_counter_timer.wait_time = 0.2
	child_counter_timer.autostart = true
	child_counter_timer.connect("timeout", _on_child_counted)
	add_child(child_counter_timer)
	
	pixel_spawn_timer.wait_time = 0.2
	pixel_spawn_timer.autostart = true
	pixel_spawn_timer.connect("timeout", _on_pixel_spawn_timer_timeout)
	add_child(pixel_spawn_timer)
	
	$Collector.connect("initial_destroyed", _on_collector_initial_destroyed)
	
	GlobalVariables.reset()


func _on_pixel_spawn_timer_timeout():
	for i in range(pow(2, current_scale)):
		var damaging_ration = 0.1 / float(current_scale)
		var collider = collider_factory.create_collider(damaging_ration)
		var x_zoom_ratio = 1.0 / float($Camera2D.zoom.x)
		var y_zoom_ratio = 1.0 / float($Camera2D.zoom.y)
		var x_position = base_screen_dimensions.x * x_zoom_ratio
		var y_position = randi_range(
			-(base_screen_dimensions.y * y_zoom_ratio),
			(base_screen_dimensions.y * y_zoom_ratio)
		)
		
		collider.position = Vector2(
			x_position, 
			y_position
		)
		
		add_child(collider)


func _on_collector_initial_destroyed():
	$ExplosionAudioPlayer.play()
	await $ExplosionAudioPlayer.finished
	$CanvasLayer/PauseMenu.set_label_message("Game over")
	$CanvasLayer/PauseMenu.trigger()
	return


func _on_child_counted():
	var different = GlobalVariables.current_child_count != last_child_count
	var difference = GlobalVariables.current_child_count - last_child_count
	last_child_count = GlobalVariables.current_child_count
	update_child_counter()
	
	if GlobalVariables.current_child_count >= GlobalVariables.CHILD_COUNT_GOAL:
		$CanvasLayer/PauseMenu.set_label_message("You win!")
		$CanvasLayer/PauseMenu.trigger()
		return
	
	if different:
		play_child_counter_audio_effect(difference)
	
	update_scale()


func play_child_counter_audio_effect(difference: int):
	if difference > 0 and not $ConnectAudioPlayer.playing:
		$ConnectAudioPlayer.play()
		
	if difference < 0:
		$ExplosionAudioPlayer.play()



func update_child_counter():
	$CanvasLayer/HBoxContainer/ChildCountLabel.text = str(GlobalVariables.current_child_count) + "/" + str(GlobalVariables.CHILD_COUNT_GOAL)


func update_scale():
	if GlobalVariables.current_scale == GlobalVariables.MAX_SCALE:
		return
	
	for count_scale in GlobalVariables.CHILD_COUNT_SCALES:
		var required_child_count = GlobalVariables.CHILD_COUNT_SCALES[count_scale]
		
		if GlobalVariables.current_child_count >= required_child_count and count_scale > current_scale:
			change_scale(count_scale)
			break
		
		if GlobalVariables.current_child_count < required_child_count and current_scale >= count_scale:
			change_scale(count_scale - 1)
			break


func change_scale(new_scale: int):
	var increasing = new_scale > current_scale
	
	current_scale = new_scale
	collider_factory.current_scale = current_scale
	GlobalVariables.change_scale(current_scale)
	
	var camera_zoom = float($Camera2D.zoom.x) / 2.0
	
	if not increasing:
		camera_zoom = float($Camera2D.zoom.x) * 2.0
	
	var tween = get_tree().create_tween()
	tween.tween_property($Camera2D, "zoom", Vector2(camera_zoom, camera_zoom), 3)
	await tween.finished
