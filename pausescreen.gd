extends Control

@onready var to_title = preload("res://title_screen_final.tscn") as PackedScene

@onready var resume_button = $CanvasLayer2/HBoxContainer/VBoxContainer/resume as Button
@onready var quit_game_button = $CanvasLayer2/HBoxContainer/VBoxContainer/Quit_Game as Button
@onready var buttons = [resume_button, quit_game_button]
@onready var pause_menu = $"."

@export var tween_duration: float = 0.05

func _ready():
	Global.is_pause_menu_active = true
	pause()
	release_all_focus()

	# Setup button behavior
	for button in buttons:
		button.focus_mode = Control.FOCUS_ALL
		button.mouse_entered.connect(func(): on_button_focused(button))
		button.mouse_exited.connect(func(): on_button_unfocused(button))
		button.focus_entered.connect(func(): on_button_focused(button))
		button.focus_exited.connect(func(): on_button_unfocused(button))

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused and Global.is_pause_menu_active:
			resume()

func _input(event):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if not Global.using_controller and Global.is_pause_menu_active:
				Global.using_controller = true
				resume_button.grab_focus()
	elif event is InputEventMouseMotion or event is InputEventMouseButton or event is InputEventKey:
		if Global.using_controller:
			Global.using_controller = false
			release_all_focus()

func pause():
	Global.is_pause_menu_active = true
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	if Global.using_controller:
		await get_tree().create_timer(0.1).timeout
		resume_button.grab_focus()

func resume():
	Global.is_pause_menu_active = false
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await get_tree().create_timer(0.3).timeout
	release_all_focus()
	queue_free()

func _on_resume_pressed():
	resume()

func _on_quit_game_pressed():
	get_tree().change_scene_to_packed(to_title)

# --- Focus Logic ---
func release_all_focus():
	for button in buttons:
		if button.has_focus():
			button.release_focus()

# --- Tween Logic ---
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func on_button_focused(button: Button):
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2(1.2, 1.2), tween_duration)

func on_button_unfocused(button: Button):
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2(1.0, 1.0), tween_duration)
