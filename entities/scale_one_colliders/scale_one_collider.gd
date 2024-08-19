class_name ScaleOneCollider extends BaseCollider

var is_core: bool = false


func setup():
	screen_notifier = $VisibleOnScreenNotifier2D
	damage = 1


func set_as_core():
	is_core = true
	$Sprite2D.frame = 0


func set_as_part():
	super()
	$Sprite2D.frame = randi_range(1, 4)


func set_as_debris():
	super()
	$Sprite2D.frame = randi_range(32, 35)
