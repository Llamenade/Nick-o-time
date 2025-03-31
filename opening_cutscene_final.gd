extends Node2D

@onready var to_game = preload("res://tutorial_level_final.tscn") as PackedScene
@onready var clock = $CanvasLayer/clock
# Called when the node enters the scene tree for the first time.
func _ready():
	clock.visible = false
	clock.modulate.a = 0.0 # Replace with function body.

func quit_on_no():
	get_tree().quit()

func to_game_on_ok():
	get_tree().change_scene_to_packed(to_game)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_clock():
	clock.visible = true  # Make it visible
	var tween = get_tree().create_tween()
	tween.tween_property(clock, "modulate:a", 1.0, 1.5)
