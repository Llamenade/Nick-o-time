extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if Input.is_action_pressed("left") and Input.is_action_pressed("up"):
		animated_sprite.play("leftup")
	elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
		animated_sprite.play("rightup")
	elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
		animated_sprite.play("leftdown")
	elif Input.is_action_pressed("right") and Input.is_action_pressed("down"):
		animated_sprite.play("rightdown")
	elif Input.is_action_pressed("right"):
		animated_sprite.play("right")
	elif Input.is_action_pressed("left"):
		animated_sprite.play("left")
	elif Input.is_action_pressed("down"):
		animated_sprite.play("down")
	elif Input.is_action_pressed("up"):
		animated_sprite.play("up")
	else:
		animated_sprite.stop()
