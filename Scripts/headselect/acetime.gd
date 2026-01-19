extends Sprite2D

@onready var select_sound = $"../../../../SelectSFX"

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.part_selected == 'Head':
			if is_pixel_opaque(get_local_mouse_position()):
				Global.current_head = 'ace'
				select_sound.play()
				
				
				
@onready var highlight = $highlight

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.current_head == 'ace':
		highlight.show()
	else:
		highlight.hide()
