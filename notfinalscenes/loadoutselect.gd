extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/AnimationPlayer.play("fade")
	Global.is_loadout_screen_visible = true
	$CanvasLayer.layer = 10

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and get_tree().paused and Global.is_loadout_screen_visible:
		$CanvasLayer/AnimationPlayer.play_backwards("fade")
		await get_tree().create_timer(0.3).timeout
		Global.is_loadout_screen_visible = false
		$CanvasLayer.layer = 0
