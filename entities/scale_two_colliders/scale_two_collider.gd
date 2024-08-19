class_name ScaleTwoCollider extends BaseCollider


func setup():
	min_size = GlobalVariables.CHILD_COUNT_SCALES[2]
	screen_notifier = $VisibleOnScreenNotifier2D
	damage = 2
	hit_points = 4


func set_as_part():
	super()
	$Sprite2D.frame = randi_range(16, 19)


func set_as_debris():
	super()
	$Sprite2D.frame = randi_range(32, 35)
