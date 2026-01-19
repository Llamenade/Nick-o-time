extends CharacterBody2D

@export var speed: float = 600
@export var direction: Vector2 = Vector2.RIGHT
@export var lifetime: float = 2.0  # Bullet disappears after 2 seconds

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D  # Get AnimatedSprite2D

func _physics_process(delta):
	if speed > 0:  # Move only if not destroyed
		var collision = move_and_collide(direction * speed * delta)  # Detect collisions
		if collision:
			_on_hit(collision.get_collider())  # Handle impact
	
	lifetime -= delta
	if lifetime <= 0:
		queue_free()

func _on_hit(body):
	print("Bullet hit:", body.name)  # Debugging

	# Ignore if the bullet collides with itself
	if body == self:
		return

	speed = 0  # Stop movement

	if body.has_method("receive_hit"):  # Only call receive_hit if the method exists
		body.receive_hit()

	# Play the destroy animation if available
	if sprite.sprite_frames.has_animation("bulletbreak"):
		sprite.play("bulletbreak")
		sprite.animation_finished.connect(_on_animation_finished)
	else:
		queue_free()  # Delete immediately if no animation

func _on_animation_finished():
	queue_free()  # Delete bullet after animation
