class_name Jumping extends State

@export var character: CharacterBody2D
@export var idle_state: Idle

var speed = 100
var previous_velocity: Vector2 = Vector2.ZERO
var gravity: int = 250
var jump_velocity: int = -250
var buffered_input_threshold: int = 100
var buffered_input: bool = false


func enter():
	previous_velocity = Vector2.ZERO
	character.velocity.y = jump_velocity
	character.move_and_slide()


func physics_update(delta: float):
	if character.is_on_floor():
		if buffered_input:
			character.velocity.y = jump_velocity
			buffered_input = false
		else:
			transitioned.emit(idle_state)
			return
	
	if not buffered_input and Input.is_action_just_pressed("ui_up") and character.velocity.y > buffered_input_threshold:
		buffered_input = true
		
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		character.velocity.x = direction * speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
	
	if Input.is_action_just_released("ui_up"):
		character.velocity.y *= 0.4
	
	character.velocity.y += gravity * delta
	character.velocity.x = lerp(previous_velocity.x, character.velocity.x, 0.1)
	
	previous_velocity = character.velocity
	character.move_and_slide()
