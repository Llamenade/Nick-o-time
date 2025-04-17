extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.is_charm_selected:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.clockcharm = false
				Global.jumpcharm = true
				
				
@onready var highlight = $highlight
@onready var animatedjump = $"../../CharmOptions/Jump/Control/animatedjump"

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.jumpcharm:
		highlight.show()
		animatedjump.play("jump")
	else:
		highlight.hide()	
		animatedjump.play("reset")
	
