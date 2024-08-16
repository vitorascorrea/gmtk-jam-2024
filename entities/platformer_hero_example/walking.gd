class_name Walking extends State

@export var character: CharacterBody2D
@export var idle_state: Idle
@export var jumping_state: Jumping

var speed = 100


func physics_update(delta: float):
	if Input.is_action_just_pressed("ui_up"):
		transitioned.emit(jumping_state)
		return

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		character.velocity.x = direction * speed
	else:
		transitioned.emit(idle_state)
	
	character.move_and_slide()
