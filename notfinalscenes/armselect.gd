extends Sprite2D

@onready var armselect = $armselect

func _process(delta: float):
	
	if Global.current_head == 'mino':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/arms/minoarms.png")
	elif Global.current_head == 'tina':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/arms/tinaarms.png")
	elif Global.current_head == 'martian':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/arms/martianarms.png")
	elif Global.current_head == 'demon':
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/arms/demonarms.png")
	else:
		$".".texture = preload("res://Nick O. Time Assets/hub/loadout/loudoutselect/customizer/arms/arms.png")
