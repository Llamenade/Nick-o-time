extends Sprite2D

@onready var charm = $Control/animatedcharm
@onready var charmselect = $charmselect

func _process(delta: float):
	if Global.clockcharm:
		charm.play("clockcharm")
	elif Global.jumpcharm:
		charm.play("jumpcharm")
	elif Global.shadowcharm:
		charm.play("shadowcharm")
	elif Global.bouldercharm:
		charm.play("bouldercharm")
	
	if Global.is_charm_selected:
		if Global.clockcharm:
			charmselect.play("clockselect")
		if Global.jumpcharm or Global.shadowcharm or Global.bouldercharm:
			charmselect.play("defaultselect")
	else:
		charmselect.play("invis")
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.is_arms_selected = false
				Global.is_head_selected = false
				Global.is_torso_selected = false
				Global.is_legs_selected = false
				Global.is_charm_selected = true
				Global.is_gun_selected = false
