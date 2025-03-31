extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade_to_black")
	$AnimationPlayer.speed_scale = 0.075
	
