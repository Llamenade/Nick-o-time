extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D  # Get AnimatedSprite2D

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)  # Detect when animation ends

func receive_hit():
	print("Target Dummy was hit!")  # Debugging message
	
	if sprite.sprite_frames.has_animation("hitted"):  # Ensure the animation exists
		sprite.play("hitted")  
	else:
		print("No 'hitted' animation found!")  

func _on_animation_finished():
	sprite.play("idle")  # Return to idle after hit animation
