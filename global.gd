extends Node

var using_controller: bool = false

#loadout
var is_head_selected: bool = true
var is_torso_selected: bool = false
var is_arms_selected: bool = false
var is_legs_selected: bool = false
var is_charm_selected: bool = false
var is_gun_selected: bool = false
var is_loadout_screen_visible: bool = false

#headoptions
var nikotime: bool = true
var justintime: bool = false
var archytime: bool = false
var chilltime: bool = false
var oogatime: bool = false
var minotime: bool = false
var caesartime: bool = false
var sirtime: bool = false
var echotime: bool = false
var acetime: bool = false
var privatetime: bool = false
var tinatime: bool = false
var martiantime: bool = false
var demontime: bool = false

#charmoptions
var clockcharm: bool = true
var jumpcharm: bool = false
var shadowcharm: bool = false
var bouldercharm: bool = false

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
#Ice map
var is_abominablesnowman_level: bool = false
var is_smilodon_level: bool = false
var is_woolymammoth_level: bool = false
#Stone Map
var is_caveman_level: bool = false
var is_direwolf_level: bool = false
var is_ent_level: bool = false
#Bronze Map
var is_kingtut_level: bool = false
var is_minotaur_level: bool = false
var is_mayanking_level: bool = false
#Iron Map
var is_charbydis_level: bool = false
var is_achilles_level: bool = false
var is_manticore_level: bool = false
