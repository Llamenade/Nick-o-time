extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.is_charm_selected:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.clockcharm = false
				Global.jumpcharm = false
				Global.shadowcharm = true
				Global.bouldercharm = false
				
@onready var highlight = $highlight
@onready var animatedshadow = $"../../CharmOptions/Shadow/Control/animatedshadow"

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.shadowcharm:
		highlight.show()
		animatedshadow.play("shadow")
	else:
		highlight.hide()	
		animatedshadow.play("reset")
	
