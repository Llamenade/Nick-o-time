extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.part_selected == 'Charm':
			if is_pixel_opaque(get_local_mouse_position()):
				Global.current_charm = 'jump'
				
				
@onready var highlight = $highlight
@onready var animatedjump = $"../../CharmOptions/Jump/Control/animatedjump"

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.current_charm == 'jump':
		highlight.show()
		animatedjump.play("jump")
	else:
		highlight.hide()	
		animatedjump.play("reset")
	
