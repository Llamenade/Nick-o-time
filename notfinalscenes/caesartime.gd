extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.is_head_selected:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.nikotime = false
				Global.justintime = false
				Global.archytime = false
				Global.chilltime = false
				Global.oogatime = false
				Global.minotime = false
				Global.caesartime = true
				Global.sirtime = false
				Global.echotime = false
				
@onready var highlight = $highlight

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.caesartime:
		highlight.show()
	else:
		highlight.hide()
