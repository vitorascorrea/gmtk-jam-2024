class_name BlueState extends State

@export var color_rect: ColorRect
@export var red_state: RedState


func enter():
	color_rect.color = Color.BLUE


func update(delta: float) -> void:	
	if Input.is_action_just_pressed("ui_left"):
		transitioned.emit(red_state)
