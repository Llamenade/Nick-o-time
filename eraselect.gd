extends Control

@onready var center: Node2D = $Center
@onready var label: RichTextLabel = $Label  # Reference to the label displaying the button text
@onready var buttons: Array = [
	$Center/Dinosaur_Age/Button1, $Center/Ice_Age/Button2, $Center/Stone_Age/Button3,
	$Center/Bronze_Age/Button4, $Center/Iron_Age/Button5, $Center/Medieval_Age/Button6,
	$Center/Gunpowder_Age/Button7, $Center/Industrial_Age/Button8, $Center/War_Age/Button9,
	$Center/Modern_Age/Button10, $Center/Future_Age/Button11, $Center/Apocalypse_Age/Button12
]
@onready var menu_gui: Control = $"."  # Your menu overlay (CanvasLayer or Control)
@onready var current_index: int = 0
var is_rotating: bool = false  # Track if the menu is visible
var last_focused_button: int = 0  # Store the index of the last focused button

# Corresponding names for each button
var button_names: Array = [
	"Dinosaur Age", "Ice Age", "Stone Age", "Bronze Age", "Iron Age",
	"Medieval Age", "Gunpowder Age", "Industrial Age", "War Age",
	"Modern Age", "Future Age", "Apocalypse Age"
]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # Ensure input processes when paused
	buttons[current_index].grab_focus()
	$AnimationPlayer.play("RESET")
	for button in buttons:
		button.pivot_offset = button.size / 2  # Center pivot
		button.scale = Vector2(0.5, 0.5)  # Hide menu at the start

	# Connect each button to hide the GUI when clicked and update label
	for i in range(buttons.size()):
		buttons[i].connect("pressed", Callable(self, "_on_button_pressed").bind(i))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("map") and !get_tree().paused:
		toggle_menu()
	elif event.is_action_pressed("map") and get_tree().paused:
		resume()  # Toggle the menu visibility on key press
	
	# Only process rotation inputs when the game is paused and menu is active
	if get_tree().paused and not is_rotating:
		if event.is_action_pressed("ui_right"):
			rotate_center(-30, 1)
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("ui_left"):
			rotate_center(30, -1)
			get_viewport().set_input_as_handled()

func toggle_menu() -> void:
	$AnimationPlayer.play("pause")
	get_tree().paused = true  # Show the menu
	last_focused_button = current_index  # Save the current focused button index
	buttons[last_focused_button].grab_focus()

func _on_button_pressed(index: int) -> void:
	label.text = button_names[index]  # Update the label when button is pressed
	resume()

func resume() -> void:
	$AnimationPlayer.play_backwards("pause")
	get_tree().paused = false  # Hide the menu GUI

func rotate_center(degrees: float, direction: int) -> void:
	is_rotating = true
	
	current_index = (current_index + direction) % buttons.size()
	if current_index < 0:
		current_index = buttons.size() - 1
	
	var tween = create_tween()  # Create tween tied to this node
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)  # Tween runs even when paused
	tween.tween_property(center, "rotation_degrees", center.rotation_degrees + degrees, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func():
		buttons[current_index].grab_focus()
		is_rotating = false  # Allow new inputs after rotation completes
	)
	
@export var tween_duration: float = 0.05


func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	if object.has_meta("active_tween"):
		var active_tween = object.get_meta("active_tween") as Tween
		if active_tween and active_tween.is_running():
			active_tween.kill()  # Cancel the old tween

	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	object.set_meta("active_tween", tween)  # Store the tween reference



func _process(delta: float) -> void:
	btn_focused(buttons[current_index])

func btn_focused(button: Button):
	button.pivot_offset = button.size / 2
	if button.has_focus():  # Ensure proper scaling center
		start_tween(button, "scale", Vector2.ONE, tween_duration)
	else:
		start_tween(button, "scale", Vector2(0.5, 0.5), tween_duration)

	# Force whole pixel positioning
	button.position = button.position.floor()
