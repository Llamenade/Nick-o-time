extends Node

var using_controller: bool = false

func _input(event):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if not Global.using_controller:
				Global.using_controller = true
	elif event is InputEventMouseMotion or event is InputEventMouseButton or event is InputEventKey:
		if Global.using_controller:
			Global.using_controller = false
			
#Level Select
var is_wheel_visible: bool = false
var is_pause_menu_active: bool = false
var is_icon_visible: bool = false
#Dinosaur map
var is_trex_level: bool = false
var is_pterodactyl_level: bool = false
var is_mosasaurus_level: bool = false
