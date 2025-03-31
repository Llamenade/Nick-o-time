extends CharacterBody2D

@onready var to_hub = preload("res://level_select_final.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func walk_into():
	get_tree().change_scene_to_packed(to_hub)
	
