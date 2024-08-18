class_name BaseCollider extends StaticBody2D

var detection_area: Area2D
var screen_notifier: VisibleOnScreenNotifier2D
var owned: bool = false
var speed: int = 100
var min_size: int = 1


func setup():
	pass


func _ready():
	setup()
	
	if detection_area != null:
		detection_area.connect("body_entered", _on_detection_area_body_entered)
	
	screen_notifier.connect("screen_exited", _on_screen_notifier_screen_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not owned:
		position.x -= speed * delta


func set_owned():
	owned = true
	
	if is_instance_valid(detection_area):
		detection_area.queue_free()
	
	if is_instance_valid(screen_notifier):
		screen_notifier.queue_free()


func _on_screen_notifier_screen_exited() -> void:
	if not owned:
		queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if not owned and body.owned and GlobalVariables.current_child_count < min_size:
		body.queue_free()
