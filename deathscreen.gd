extends Control

@onready var to_hub = preload("res://level_select_final.tscn") as PackedScene


@onready var progress = $CanvasLayer2/ProgressBar
@onready var retry_button = $CanvasLayer2/HBoxContainer/VBoxContainer/retry as Button
@onready var hub_button = $CanvasLayer2/HBoxContainer/VBoxContainer/hub as Button
@onready var buttons = [retry_button, hub_button]
@onready var pause_menu = $"."

@export var tween_duration: float = 0.05

@onready var boss = $"../SubViewportContainer/SubViewport/samurailevel/MasterHanji"

func _ready():
	progress.value = boss.health
	pause()
	release_all_focus()

	# Setup button behavior
	for button in buttons:
		button.focus_mode = Control.FOCUS_ALL
		button.mouse_entered.connect(func(): on_button_focused(button))
		button.mouse_exited.connect(func(): on_button_unfocused(button))
		button.focus_entered.connect(func(): on_button_focused(button))
		button.focus_exited.connect(func(): on_button_unfocused(button))

func _input(event):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if not Global.using_controller and Global.is_pause_menu_active:
				Global.using_controller = true
				retry_button.grab_focus()
	elif event is InputEventMouseMotion or event is InputEventMouseButton or event is InputEventKey:
		if Global.using_controller:
			Global.using_controller = false
			release_all_focus()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	if Global.using_controller:
		await get_tree().create_timer(0.1).timeout
		retry_button.grab_focus()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await get_tree().create_timer(0.3).timeout
	release_all_focus()
	queue_free()





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


func _on_resume_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_game_pressed() :
	get_tree().paused = false
	get_tree().change_scene_to_packed(to_hub)
