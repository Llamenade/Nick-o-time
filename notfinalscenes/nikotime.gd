extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.is_head_selected:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.clockcharm = true
				
				
@onready var highlight = $highlight

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.nikotime:
		highlight.show()
	else:
		highlight.hide()	
