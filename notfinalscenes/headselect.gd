extends Sprite2D

@onready var headselect = $headselect

func _process(delta: float):
	if Global.current_head == 'niko':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/nikotime.png")
	elif Global.current_head == 'justin':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/justintime.png")
	elif Global.current_head == 'archy':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/archytime.png")
	elif Global.current_head == 'chill':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/chilltime.png")
	elif Global.current_head == 'ooga':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/oogatime.png")
	elif Global.current_head == 'mino':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/minotime.png")
	elif Global.current_head == 'caesar':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/caesartime.png")
	elif Global.current_head == 'sir':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/sirtime.png")
	elif Global.current_head == 'echo':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/echotime.png")
	elif Global.current_head == 'ace':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/acetime.png")
	elif Global.current_head == 'private':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/privatetime.png")
	elif Global.current_head == 'tina':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/tinatime.png")
	elif Global.current_head == 'martian':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/martiantime.png")
	elif Global.current_head == 'demon':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/head/demontime.png")
		
	if Global.part_selected == 'Head':
		if Global.current_head == 'archy':
			headselect.play("archytimeselect")
		elif Global.current_head == 'chill':
			headselect.play("chilltimeselect")
		elif Global.current_head == 'ooga':
			headselect.play("oogatimeselect")
		elif Global.current_head == 'mino':
			headselect.play("minotimeselect")
		elif Global.current_head == 'caesar':
			headselect.play("caesartimeselect")
		elif Global.current_head == 'sir':
			headselect.play("sirtimeselect")
		elif Global.current_head == 'echo':
			headselect.play("echotimeselect")
		elif Global.current_head == 'ace':
			headselect.play("acetimeselect")
		elif Global.current_head == 'private':
			headselect.play("privatetimeselect")
		elif Global.current_head == 'tina':
			headselect.play("tinatimeselect")
		elif Global.current_head == 'martian':
			headselect.play("martiantimeselect")
		elif Global.current_head == 'demon':
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
				Global.part_selected = 'Head'
