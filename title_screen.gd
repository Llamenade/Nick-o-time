extends Control

@onready var new_game_button = $CanvasLayer2/HBoxContainer/VBoxContainer/New_Game as Button
@onready var quit_game_button = $CanvasLayer2/HBoxContainer/VBoxContainer/Quit_Game as Button
@onready var start_game = preload("res://opening_cutscene_final.tscn") as PackedScene

# Array of all buttons for focus management
@onready var buttons = [new_game_button, quit_game_button]

@export var tween_duration: float = 0.05  # Duration for the scaling effect

func _ready():
	get_tree().paused = false
	if Global.using_controller:
		new_game_button.grab_focus()
	else:
		release_all_focus()
	# Set up button signals
	new_game_button.button_up.connect(on_new_game_pressed)
	quit_game_button.button_up.connect(on_quit_game_pressed)
	
	# Ensure all buttons can take focus and start with no focus
	for button in buttons:
		button.focus_mode = Control.FOCUS_ALL
		button.mouse_entered.connect(func(): on_button_focused(button))
		button.mouse_exited.connect(func(): on_button_unfocused(button))
		button.focus_entered.connect(func(): on_button_focused(button))
		button.focus_exited.connect(func(): on_button_unfocused(button))

func _input(event):
	# Detect controller input
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if not Global.using_controller:
			Global.using_controller = true
			new_game_button.grab_focus() # First button gains focus for controller
	
	# Detect mouse/keyboard input
	elif event is InputEventMouseMotion or event is InputEventMouseButton or event is InputEventKey:
		if Global.using_controller:
			Global.using_controller = false
			release_all_focus()

func release_all_focus():
	# Release focus from any button that has it
	for button in buttons:
		if button.has_focus():
			button.release_focus()

func on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)

func on_quit_game_pressed() -> void:
	get_tree().quit()

# --- Button Scaling Functions ---
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)

func on_button_focused(button: Button):
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2(1.2, 1.2), tween_duration)  # Grow to 1.2x

func on_button_unfocused(button: Button):
	button.pivot_offset = button.size / 2
	start_tween(button, "scale", Vector2(1.0, 1.0), tween_duration)  # Shrink back to normal
