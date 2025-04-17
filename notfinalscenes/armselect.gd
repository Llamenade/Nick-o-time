extends Sprite2D

@onready var armselect = $armselect

func _process(delta: float):
	if Global.is_arms_selected:
		armselect.play("defaultselect")
	else:
		armselect.play("invis")
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.is_arms_selected = true
				Global.is_head_selected = false
				Global.is_torso_selected = false
				Global.is_legs_selected = false
				Global.is_charm_selected = false
				Global.is_gun_selected = false
