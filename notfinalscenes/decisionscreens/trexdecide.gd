extends Control

@onready var fight_button = $CanvasLayer/Control/fight as Button
@onready var cancel_button = $CanvasLayer/Control/cancel as Button
@onready var buttons = [fight_button, cancel_button]
var using_controller = false
@export var tween_duration: float = 0.05
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.is_trex_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/dinosaur/trexhover.png")
	elif Global.is_pterodactyl_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/dinosaur/pterodactylhover.png")
	elif Global.is_mosasaurus_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/dinosaur/mosasaurhover.png")
	elif Global.is_smilodon_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/ice/sabretoothhover.png")
	elif Global.is_abominablesnowman_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/ice/abominablesnowmanhover.png")
	elif Global.is_woolymammoth_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/ice/woolymammothhover.png")
	elif Global.is_caveman_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/stone/cavemanhover.png")
	elif Global.is_ent_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/stone/enthover.png")
	elif Global.is_direwolf_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/stone/direwolfhover.png")
	elif Global.is_kingtut_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/bronze/kingtuthover.png")
	elif Global.is_minotaur_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/bronze/minotaurhover.png")
	elif Global.is_mayanking_level:
		$CanvasLayer/Control/TextureRect.texture = preload("res://Nick O. Time Assets/hub/eraselect/bronze/mayankinghover.png")
	release_all_focus()
	Global.is_icon_visible = true
	$AnimationPlayer.play("RESET")
	await get_tree().create_timer(0.3).timeout
	get_tree().paused = true
	
	for button in buttons:
		button.focus_mode = Control.FOCUS_ALL
		button.mouse_entered.connect(func(): on_button_focused(button))
		button.mouse_exited.connect(func(): on_button_unfocused(button))
		button.focus_entered.connect(func(): on_button_focused(button))
		button.focus_exited.connect(func(): on_button_unfocused(button))
	

func _on_cancel_pressed():
	$AnimationPlayer.play_backwards("RESET")
	await get_tree().create_timer(0.3).timeout
	get_tree().paused = false
	Global.is_icon_visible = false
	queue_free()
	
func _input(event):
	if event.is_action_pressed("pause") and Global.is_icon_visible:
		_on_cancel_pressed()
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if not using_controller:
			using_controller = true
			if Global.is_icon_visible:
				fight_button.grab_focus()
	elif event is InputEventMouseMotion or event is InputEventMouseButton or event is InputEventKey:
		if using_controller:
			using_controller = false
			release_all_focus()

func release_all_focus():
	for button in buttons:
		if button.has_focus():
			button.release_focus()
			
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func on_button_focused(button: Button):
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2(1.2, 1.2), tween_duration)

func on_button_unfocused(button: Button):
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2(1.0, 1.0), tween_duration)
	
@onready var trex_level = preload("res://notfinalscenes/trex_level_final.tscn") as PackedScene

func _on_fight_pressed() -> void:
	get_tree().paused = false
	if Global.is_trex_level:
		get_tree().change_scene_to_packed(trex_level)
