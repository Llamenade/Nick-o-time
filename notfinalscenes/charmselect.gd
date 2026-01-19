extends Sprite2D

@onready var charm = $Control/animatedcharm
@onready var charmselect = $charmselect

func _process(delta: float):
	if Global.current_charm == 'clock':
		charm.play("clockcharm")
	elif Global.current_charm == 'jump':
		charm.play("jumpcharm")
	elif Global.current_charm == 'shadow':
		charm.play("shadowcharm")
	elif Global.current_charm == 'boulder':
		charm.play("bouldercharm")
	elif Global.current_charm == 'tapemeasurer':
		charm.play("tapemeasurercharm")
	
	if Global.part_selected == 'Charm':
		if Global.current_charm == 'clock':
			charmselect.play("clockselect")
		if Global.current_charm == 'tapemeasurer':
			charmselect.play("tapeselect")
		else:
			charmselect.play("defaultselect")
	else:
		charmselect.play("invis")
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.part_selected = 'Charm'
