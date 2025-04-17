extends Control

var loadoutselect = preload("res://notfinalscenes/loadoutselect.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Global.is_wheel_visible:
		queue_free()
	if !Global.is_loadout_screen_visible:
		loadoutselect.instantiate().queue_free()
func _on_loadout_button_pressed() -> void:
	get_tree().current_scene.add_child(loadoutselect.instantiate())
	queue_free()
	
