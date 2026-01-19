extends Camera2D

@onready var player: Node2D = $"../Player"

func _process(delta):
	position.x = player.position.x
