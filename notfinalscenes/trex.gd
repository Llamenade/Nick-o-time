extends CharacterBody2D

@export var SPEED = 120.0
@onready var trex = $trex
@onready var player = $"../TileMap/Player"

func _physics_process(delta):
	if player == null:
		return

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
