extends Sprite2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Global.is_charm_selected:
			if is_pixel_opaque(get_local_mouse_position()):
				Global.clockcharm = true
				Global.jumpcharm = false
				Global.shadowcharm = false
				Global.bouldercharm = false
				
				
@onready var highlight = $highlight
@onready var animatedclock = $"../../CharmOptions/Clock/Control/animatedclock"

func _ready() -> void:
	highlight.hide()
				
func _process(delta: float) -> void:
	if Global.clockcharm:
		highlight.show()
		animatedclock.play("clock")
	else:
		highlight.hide()	
		animatedclock.play("reset")
	
