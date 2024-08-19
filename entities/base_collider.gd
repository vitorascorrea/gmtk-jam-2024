class_name BaseCollider extends Area2D

var screen_notifier: VisibleOnScreenNotifier2D
var owned: bool = false
var base_speed: int = 25
var min_size: int = 1
var child_count: int = 0
var grabbable: bool = true
var last_scale_checked: int = -1
var rotation_direction = [-1, 1].pick_random()
var hit_points: int = 3
var damage: int = 1

func setup():
	pass


func _ready():
	setup()
	
	self.connect("area_entered", _on_area_entered)
	self.connect("tree_exiting", _on_tree_exiting)
	screen_notifier.connect("screen_exited", _on_screen_notifier_screen_exited)
	
	update_highlight()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not owned:
		position.x -= base_speed * GlobalVariables.current_scale * delta
		rotation_degrees += rotation_direction
		update_highlight()


func _on_tree_exiting():
	GlobalVariables.current_child_count -= child_count


func set_as_part():
	grabbable = true


func set_as_debris():
	grabbable = false


func set_owned():
	owned = true
	
	if is_instance_valid(screen_notifier):
		screen_notifier.queue_free()


func collect(collider: BaseCollider) -> void:
	collider.set_owned()
	collider.call_deferred("reparent", self)
	
	child_count += 1
	GlobalVariables.current_child_count += 1


func destroy():
	queue_free()


func _on_screen_notifier_screen_exited() -> void:
	if not owned:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is not BaseCollider:
		return
	
	# Stray collider that can break owned colliders
	if not owned and area.owned and GlobalVariables.current_child_count < min_size:
		area.destroy()
		hit_points -= area.damage
		
		if hit_points <= 0:
			destroy()
	
	# Owned collider checking if can claim collider
	elif owned and not area.owned and area.grabbable and GlobalVariables.current_child_count >= area.min_size:
		collect(area)
	
	# Owned collider checking if it can destroy collider
	elif owned and not area.owned and not area.grabbable and GlobalVariables.current_child_count >= area.min_size:
		area.destroy()


func update_highlight():
	if not is_instance_valid($Sprite2D):
		return
	
	if last_scale_checked == GlobalVariables.current_scale:
		return
	
	last_scale_checked = GlobalVariables.current_scale
		
	if min_size > GlobalVariables.CHILD_COUNT_SCALES[GlobalVariables.current_scale]:
		$Sprite2D.modulate = Color.RED
	else:
		$Sprite2D.modulate = Color.WHITE
