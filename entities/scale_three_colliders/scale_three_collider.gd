class_name ScaleThreeCollider extends BaseCollider


func setup():
	min_size = GlobalVariables.CHILD_COUNT_SCALES[3]
	screen_notifier = $VisibleOnScreenNotifier2D
	damage = 3
	hit_points = 6 * GlobalVariables.difficulty_level

func set_as_part():
	super()
	$Sprite2D.frame = randi_range(2, 5)


func set_as_debris():
	super()
	$Sprite2D.frame = randi_range(10, 13)
