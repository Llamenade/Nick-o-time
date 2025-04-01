extends Control

@onready var center: Node2D = $Center
@onready var label: RichTextLabel = $Label
@onready var cog_1: Node2D = $Center/Industrial_Age/Button8/cog1
@onready var cog_2: Node2D = $Center/Industrial_Age/Button8/cog2
@onready var ice_filter: Control = $icefilter/controlicefilter
@onready var sphere: MeshInstance3D = $Sphere

@onready var buttons: Array = [
	$Center/Dinosaur_Age/Button1, $Center/Ice_Age/Button2, $Center/Stone_Age/Button3,
	$Center/Bronze_Age/Button4, $Center/Iron_Age/Button5, $Center/Medieval_Age/Button6,
	$Center/Gunpowder_Age/Button7, $Center/Industrial_Age/Button8, $Center/War_Age/Button9,
	$Center/Modern_Age/Button10, $Center/Future_Age/Button11, $Center/Apocalypse_Age/Button12
]

@onready var menu_gui: Control = $"."  
@onready var current_index: int = 0
var is_rotating: bool = false  
var last_focused_button: int = 0  
var rotating_cogs: bool = false  

var button_names: Array = [
	"Dinosaur Age", "Ice Age", "Stone Age", "Bronze Age", "Iron Age",
	"Medieval Age", "Gunpowder Age", "Industrial Age", "War Age",
	"Modern Age", "Future Age", "Apocalypse Age"
]

@export var tween_duration: float = 0.05
@export var cog_rotation_speed: float = 100
@export var ice_texture: Texture
@export var default_texture: Texture

@onready var subviewport = $"../SubViewportContainer/SubViewport"  # Adjust path if needed

var hub_scene = preload("res://notfinalscenes/hub.tscn")  # Preload hub scene
var icehub_scene = preload("res://notfinalscenes/icehub.tscn")  # Preload icehub scene
var current_instance: Node = null  # Track the current scene instance

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	buttons[current_index].grab_focus()
	$AnimationPlayer.play("RESET")

	# Initialize ice filter transparency
	ice_filter.modulate.a = 0.0  

	# Set up button scaling and connections
	for i in range(buttons.size()):
		buttons[i].pivot_offset = buttons[i].size / 2
		buttons[i].scale = Vector2(0.5, 0.5)
		buttons[i].connect("pressed", Callable(self, "_on_button_pressed").bind(i))

	# Instantiate the hub scene on start
	switch_scene(hub_scene)

func _process(delta: float) -> void:
	btn_focused(buttons[current_index])

	# Rotate cogs only when Button8 is focused
	if rotating_cogs:
		cog_1.rotation_degrees += cog_rotation_speed * delta  # Clockwise
		cog_2.rotation_degrees -= cog_rotation_speed * delta  # Counterclockwise

func _on_button_pressed(index: int) -> void:
	label.text = button_names[index]
	
	# Check if "Ice Age" is selected
	var is_ice_age = (button_names[index] == "Ice Age")
	fade_ice_filter(is_ice_age)  # Apply fade effect

	# Load the correct scene
	if is_ice_age:
		switch_scene(icehub_scene)
	else:
		switch_scene(hub_scene)

	resume()

func switch_scene(new_scene: PackedScene) -> void:
	# Remove the current scene if one exists
	if current_instance:
		subviewport.remove_child(current_instance)
		current_instance.queue_free()  # Free memory
	
	# Instantiate and add the new scene
	current_instance = new_scene.instantiate()
	subviewport.add_child(current_instance)

func btn_focused(button: Button):
	button.pivot_offset = button.size / 2

	if button.has_focus():
		start_tween(button, "scale", Vector2.ONE, tween_duration)
	else:
		start_tween(button, "scale", Vector2(0.5, 0.5), tween_duration)

	rotating_cogs = (button == buttons[7])  # Index 7 is Button8

	button.position = button.position.floor()

func toggle_menu() -> void:
	$AnimationPlayer.play("pause")
	get_tree().paused = true
	last_focused_button = current_index
	buttons[last_focused_button].grab_focus()

func resume() -> void:
	$AnimationPlayer.play_backwards("pause")
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("map") and !get_tree().paused:
		toggle_menu()
	elif event.is_action_pressed("map") and get_tree().paused:
		resume()

	# Only process rotation inputs when the game is paused and menu is active
	if get_tree().paused and not is_rotating:
		if event.is_action_pressed("ui_right"):
			rotate_center(-30, 1)
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("ui_left"):
			rotate_center(30, -1)
			get_viewport().set_input_as_handled()

func rotate_center(degrees: float, direction: int) -> void:
	is_rotating = true
	
	current_index = (current_index + direction) % buttons.size()
	if current_index < 0:
		current_index = buttons.size() - 1
	
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(center, "rotation_degrees", center.rotation_degrees + degrees, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func():
		buttons[current_index].grab_focus()
		is_rotating = false
	)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	if object.has_meta("active_tween"):
		var active_tween = object.get_meta("active_tween") as Tween
		if active_tween and active_tween.is_running():
			active_tween.kill()

	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	object.set_meta("active_tween", tween)

# Fades the IceFilter in or out over 0.2 seconds
func fade_ice_filter(visible: bool):
	var tween = create_tween()
	tween.tween_property(ice_filter, "modulate:a", 1.0 if visible else 0.0, 0.2)
