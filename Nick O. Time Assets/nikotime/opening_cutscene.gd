extends Control

const Balloon = preload("res://dialogue/balloon.tscn")

@onready var back_to_title = preload("res://notfinalscenes/title_screen.tscn") as PackedScene  # Cache the clock node

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready(): # Start fully transparent
	await get_tree().create_timer(15.0).timeout
	start_dialogue()
	

func start_dialogue():
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)

func show_clock():
	var tween = get_tree().create_tween()
