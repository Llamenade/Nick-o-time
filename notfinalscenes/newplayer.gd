extends CharacterBody2D

@export var SPEED : int = 250
@export var GRAVITY : int = 1100
@export var JUMP_FORCE : int = 450
@export var JUMP_CUT : float = 0.65
@export var MAX_FALL_SPEED : int = 600
@export var ACCELERATION : float = 0.2
@export var FRICTION : float = 0.15
@export var GROUND_SPEED_BOOST : float = 1.1 
@export var CROUCH_SPEED_BOOST : float = 0.3

@export var bullet_scene = preload("res://notfinalscenes/bullet.tscn") as PackedScene
@onready var shoot_sound = $shootsound
@onready var shoot_timer = $ShootTimer

@onready var collision_shape = $CollisionPolygon2D
@onready var crouch_collision_shape = $CrouchCollisionPolygon2D
@onready var ceiling_check = $CeilingCheck
@onready var shooting_spot = $PlayerBody/gun/Marker2D
@onready var playerbody = $PlayerBody
@onready var head = $PlayerBody/head
@onready var torso = $PlayerBody/torso
@onready var arms = $PlayerBody/arms
@onready var legs = $PlayerBody/legs
@onready var charm = $PlayerBody/charm
@onready var gun = $PlayerBody/gun

var is_jumping = false
var is_crouching = false
var is_shooting = false
var last_direction = 1

func _ready(): 
	
	
	collision_shape.disabled = false
	ceiling_check.enabled = true
	if not bullet_scene:
		print("Error: Bullet scene not loaded!")
	if not shoot_timer:
		print("Error: ShootTimer not found!")
	else:
		shoot_timer.wait_time = 0.2
		shoot_timer.one_shot = false
		shoot_timer.connect("timeout", _on_shoot_timer_timeout)

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	direction = int(sign(direction))

	var ground_speed = 1
	var crouch_speed = 1
	if is_on_floor():
		ground_speed = GROUND_SPEED_BOOST
		if is_crouching:
			crouch_speed = CROUCH_SPEED_BOOST
			collision_shape.disabled = true
			crouch_collision_shape.disabled = false
		else:
			crouch_speed = 1
			collision_shape.disabled = false
			crouch_collision_shape.disabled = true

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED * ground_speed * crouch_speed, ACCELERATION * SPEED)
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * SPEED)
		
	if Global.is_grappling == false:
		velocity.y = min(velocity.y + GRAVITY * delta, MAX_FALL_SPEED)

	if Input.is_action_pressed("punch"):
		is_shooting = true
		if shoot_timer.is_stopped():
			shoot_bullet()
			shoot_sound.play()
			shoot_timer.start()
	else:
		is_shooting = false
		shoot_timer.stop()

	if Input.is_action_just_pressed("jump") and is_on_floor() and not ceiling_check.is_colliding():
		velocity.y = -JUMP_FORCE
		is_jumping = true
		is_crouching = false

	if Input.is_action_just_pressed("crouch") and is_on_floor():
		is_crouching = true

	if is_on_floor():
		if Input.is_action_pressed("crouch"):
			is_crouching = true
		elif is_crouching and not ceiling_check.is_colliding():
			is_crouching = false

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT

	move_and_slide()
	
	for i in range(get_slide_collision_count()):  # Check for collisions
		var collision = get_slide_collision(i)
		if collision:
			_on_bang(collision.get_collider())

	if is_on_floor():
		if is_crouching and direction and is_shooting:
			head.play("shootwalkcrouch")
			torso.play("shootwalkcrouch")
			arms.play("shootwalkcrouch")
			legs.play("shootwalkcrouch")
			charm.play(Global.current_charm + "shootwalkcrouch")
			gun.play("shootwalkcrouch")
		elif is_crouching and direction:
			head.play("walkcrouch")
			torso.play("walkcrouch")
			arms.play("walkcrouch")
			legs.play("walkcrouch")
			charm.play(Global.current_charm + "walkcrouch")
			gun.play("default")
		elif is_crouching and is_shooting:
			head.play("shootcrouch")
			torso.play("shootcrouch")
			arms.play("shootcrouch")
			legs.play("shootcrouch")
			charm.play(Global.current_charm + "shootcrouch")
			gun.play("shootcrouch")
		elif is_crouching:
			head.play("crouch")
			torso.play("crouch")
			arms.play("crouch")
			legs.play("crouch")
			charm.play(Global.current_charm + "crouch")
			gun.play("default")
		elif is_shooting and direction:
			head.play("shootrun")
			torso.play("shootrun")
			arms.play("shootrun")
			gun.play("shootrun")
			legs.play("run")
			charm.play(Global.current_charm + "shootrun")
		elif is_shooting:
			head.play("shootidle")
			torso.play("shootidle")
			arms.play("shootidle")
			legs.play("shootidle")
			charm.play(Global.current_charm + "shootidle")
			gun.play("shootidle")
		elif direction:
			head.play("run")
			torso.play("run")
			arms.play("run")
			legs.play("run")
			charm.play(Global.current_charm + "run")
			gun.play("default")
		else:
			head.play("idle")
			torso.play("idle")
			arms.play("idle")
			legs.play("idle")
			charm.play(Global.current_charm + "idle")
			gun.play("default")
	else:
		if velocity.y < 0 and is_shooting:
			head.play("jump")
			torso.play("jump")
			arms.play("shootjump")
			legs.play("jump")
			charm.play(Global.current_charm + "jump")
			gun.play("shootjump")
		elif velocity.y < 0:
			head.play("jump")
			torso.play("jump")
			arms.play("jump")
			legs.play("jump")
			charm.play(Global.current_charm + "jump")
			gun.play("default")
		elif velocity.y >= 0 and is_shooting:
			head.play("fall")
			torso.play("fall")
			arms.play("shootfall")
			legs.play("fall")
			charm.play(Global.current_charm + "fall")
			gun.play("shootfall")
		elif velocity.y >= 0:
			head.play("fall")
			torso.play("fall")
			arms.play("fall")
			legs.play("fall")
			charm.play(Global.current_charm + "fall")
			gun.play("default")
	head.flip_h = (last_direction == 1)
	torso.flip_h = (last_direction == 1)
	arms.flip_h = (last_direction == 1)
	legs.flip_h = (last_direction == 1)
	charm.flip_h = (last_direction == 1)
	gun.flip_h = (last_direction == 1)
	velocity.x = round(velocity.x)
	velocity.y = round(velocity.y)

func _on_bang(body):
	if body and body.has_method("walk_into"):
		body.walk_into()

func shoot_bullet():
	if not is_crouching:
		var spawn_offset = shooting_spot.position + Vector2(32 * last_direction, 0)
		var spawn_position = global_position + spawn_offset
		var bullet = bullet_scene.instantiate()
		bullet.position = spawn_position
		bullet.direction = Vector2(last_direction, 0)
		get_parent().add_child(bullet)
	if is_crouching:
		var spawn_offset = shooting_spot.position + Vector2(32 * last_direction, 15)
		var spawn_position = global_position + spawn_offset
		var bullet = bullet_scene.instantiate()
		bullet.position = spawn_position
		bullet.direction = Vector2(last_direction, 0)
		get_parent().add_child(bullet)

func _on_shoot_timer_timeout():
	shoot_bullet()
	shoot_sound.play()
	
func _on_hit():
	pass
