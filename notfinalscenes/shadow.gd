extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.part_selected == 'Charm':
			if is_pixel_opaque(get_local_mouse_position()):
				Global.current_charm = 'shadow'
				
@onready var highlight = $highlight
@onready var animatedshadow = $"../../CharmOptions/Shadow/Control/animatedshadow"

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.current_charm == 'shadow':
		highlight.show()
		animatedshadow.play("shadow")
	else:
		highlight.hide()	
		animatedshadow.play("reset")
	
