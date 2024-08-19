class_name ScaleFourCollider extends BaseCollider


func setup():
	min_size = GlobalVariables.CHILD_COUNT_SCALES[4]
	screen_notifier = $VisibleOnScreenNotifier2D
	damage = 4
	hit_points = 16

func set_as_part():
	super()
	$Sprite2D.frame = randi_range(4, 7)


func set_as_debris():
	super()
	$Sprite2D.frame = randi_range(8, 11)
