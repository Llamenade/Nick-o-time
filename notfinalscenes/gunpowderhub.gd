extends Node3D

@export var rotation_speed: float = 1  # Sensitivity of rotation (degrees per frame)
@export var max_up: float = 180
@export var max_down: float = 0      # Max tilt angle to avoid flipping (degrees)
@onready var sphere = $Sphere
@onready var overlay = $overlay # Reference to your sphere node

# Store the globe's rotation as Euler angles
var rotation_x: float = 90
var rotation_z: float = 0  # Tilt (up/down)
var rotation_y: float = 24
var overlayrotation_x: float = 90
var overlayrotation_z: float = 0  # Tilt (up/down)
var overlayrotation_y: float = 24  # Spin (left/right)

# Function to apply texture directly to the sphere
	
func _process(delta):
	# Get input for rotation
	var input_x = 0.0
	var input_y = 0.0
	
	if Input.is_action_pressed("right"):  # D key - Rotate right
		input_y += 1.0
	if Input.is_action_pressed("left"):   # A key - Rotate left
		input_y -= 1.0
	if Input.is_action_pressed("down"):     # W key - Tilt up
		input_x -= 1.0
	if Input.is_action_pressed("up"):   # S key - Tilt down
		input_x += 1.0

	# Apply rotation speed and delta time
	rotation_y += input_y * rotation_speed * delta * 60  # Normalized to 60 FPS
	rotation_x += input_x * rotation_speed * delta * 60
	overlayrotation_y += input_y * 0.6 * delta * 60  # Normalized to 60 FPS
	overlayrotation_x += input_x * 0.6 * delta * 60

	# Clamp the tilt to prevent flipping over the poles
	rotation_x = clamp(rotation_x, 5, 175)
	overlayrotation_x = clamp(rotation_x, 5, 175)

	# Reset the sphere's rotation to identity to avoid gimbal lock issues
	
	sphere.transform.basis = Basis()
	overlay.transform.basis = Basis()  # Clear existing rotation

	# Apply rotations in a specific order: Y (spin) first, then X (tilt)
	sphere.rotate_y(deg_to_rad(rotation_y))  # Horizontal spin
	sphere.rotate_x(deg_to_rad(rotation_x))
	overlay.rotate_y(deg_to_rad(overlayrotation_y))  # Horizontal spin
	overlay.rotate_x(deg_to_rad(overlayrotation_x))
