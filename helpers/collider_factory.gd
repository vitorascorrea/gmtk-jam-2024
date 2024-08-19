class_name ColliderFactory extends Node

var current_scale: int = 1
var previous_scale_ratio: float = 0.2
var debris_ratio: float = 0.6


func create_collider(damaging_ratio: float = 0.05) -> BaseCollider:
	if current_scale > 1 and randf() <= previous_scale_ratio:
		return create_collider_with_type(GlobalVariables.SCENES_PER_SCALES[current_scale - 1])
	
	if current_scale < GlobalVariables.MAX_SCALE and randf() <= damaging_ratio:
		return create_collider_with_type(GlobalVariables.SCENES_PER_SCALES[current_scale + 1])
			
	return create_collider_with_type(GlobalVariables.SCENES_PER_SCALES[current_scale])


func create_collider_with_type(collider_scene) -> BaseCollider:
	var collider = collider_scene.instantiate()
	
	if randf() > debris_ratio:
		collider.set_as_part()
	else:
		collider.set_as_debris()
	
	return collider
