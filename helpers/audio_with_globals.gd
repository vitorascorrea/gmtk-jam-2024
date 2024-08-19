class_name AudioWithGlobals extends AudioStreamPlayer2D

enum TYPE {
	MUSIC,
	SFX
}

@export var type: TYPE = TYPE.MUSIC
@export var should_autoplay: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh_volume()
	
	if type == TYPE.MUSIC:
		process_mode = PROCESS_MODE_ALWAYS
	if type == TYPE.SFX:
		process_mode = PROCESS_MODE_INHERIT
	
	autoplay = should_autoplay


func refresh_volume():
	if type == TYPE.MUSIC:
		volume_db = linear_to_db(GlobalVariables.music_volume)
	if type == TYPE.SFX:
		volume_db = linear_to_db(GlobalVariables.sfx_volume)
