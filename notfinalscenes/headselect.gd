extends Sprite2D

@onready var headselect = $headselect

func _process(delta: float):
	if Global.nikotime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/nikotime.png")
	elif Global.justintime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/justintime.png")
	elif Global.archytime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/archytime.png")
	elif Global.chilltime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/chilltime.png")
	elif Global.oogatime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/oogatime.png")
	elif Global.minotime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/minotime.png")
	elif Global.caesartime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/caesartime.png")
	elif Global.sirtime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/sirtime.png")
	elif Global.echotime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/echotime.png")
	elif Global.acetime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/acetime.png")
	elif Global.privatetime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/privatetime.png")
	elif Global.tinatime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/tinatime.png")
	elif Global.martiantime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/martiantime.png")
	elif Global.demontime:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/demontime.png")
		
	if Global.is_head_selected:
		if Global.archytime:
			headselect.play("archytimeselect")
		elif Global.chilltime:
			headselect.play("chilltimeselect")
		elif Global.oogatime:
			headselect.play("oogatimeselect")
		elif Global.minotime:
			headselect.play("minotimeselect")
		elif Global.caesartime:
			headselect.play("caesartimeselect")
		elif Global.sirtime:
			headselect.play("sirtimeselect")
		elif Global.echotime:
			headselect.play("echotimeselect")
		elif Global.acetime:
			headselect.play("acetimeselect")
		elif Global.privatetime:
			headselect.play("privatetimeselect")
		elif Global.tinatime:
			headselect.play("tinatimeselect")
		elif Global.martiantime:
			headselect.play("martiantimeselect")
		elif Global.demontime:
			headselect.play("demontimeselect")
		else:
			headselect.play("defaultselect")
	else:
		headselect.play("invis")
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.is_arms_selected = false
				Global.is_head_selected = true
				Global.is_torso_selected = false
				Global.is_legs_selected = false
				Global.is_charm_selected = false
				Global.is_gun_selected = false
