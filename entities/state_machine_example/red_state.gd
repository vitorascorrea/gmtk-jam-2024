class_name RedState extends State

@export var color_rect: ColorRect
@export var blue_state: BlueState


func enter():
	color_rect.color = Color.DARK_RED


func update(delta: float) -> void:	
	if Input.is_action_just_pressed("ui_left"):
		transitioned.emit(blue_state)
