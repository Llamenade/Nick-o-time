extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var sprite = $Sprite2D

@onready var shurikens = $Shurikens


const DASH_DISTANCE := 400
const DOWN_DISTANCE := 200
const DASH_SPEED := 650

var move_counter = 0
var health = 500

var direction: Vector2
var distance_left := 0.0



func _ready():
	set_physics_process(false)
	shurikens.hide()
	sprite.play('idle')


func receive_hit():
	
	health -= 5
	sprite.modulate = Color(2,2,2,1)
	await get_tree().create_timer(0.05).timeout
	sprite.modulate = Color(1,1,1,1)
	if health <= 0:
		queue_free()

func shuriken_phase():
	sprite.rotation_degrees = 0
	shurikens.show()
	sprite.play('idle')
			
	await get_tree().create_timer(2).timeout
	shurikens.shoot()
	await get_tree().create_timer(2).timeout
	shurikens.shoot()
	await get_tree().create_timer(2).timeout
	shurikens.shoot()
	
func not_shuriken_phase():
	shurikens.hide()
	shurikens.reverse()
	self.start_dash()
	

func start_dash():
	sprite.play('dash')
	# reposition horizontally
	var x := randi_range(0, 640)
	while abs(x - player.global_position.x) <= 120:
		x = randi_range(0, 640)
	global_position.x = x
	global_position.y = 208


	# lock direction ONCE
	direction = Vector2(sign(player.global_position.x - global_position.x), 0)
	distance_left = DASH_DISTANCE

	sprite.flip_h = direction.x < 0
	await get_tree().create_timer(0.3).timeout
	set_physics_process(true)
	
	
func down_dash():
	sprite.play('dash')
	sprite.rotation_degrees = 90
	
	global_position.x = player.position.x
	
	
	global_position.y = 10
	
	direction = Vector2(0,1)
	distance_left = DOWN_DISTANCE
	await get_tree().create_timer(0.25).timeout
	set_physics_process(true)

func choose_dash(move_counter):
	if move_counter % 2 == 0:
		var r := randi() % 100  # random number 0-99
		if r < 75:
			down_dash()  # 65% chance
		else:
			start_dash()  # 35% chance
	else:
		var r := randi() % 100  # random number 0-99
		if r < 75:
			start_dash()  # 65% chance
		else:
			down_dash()  # 35% chance
		
func _physics_process(delta):
	if move_counter > 5:
		set_physics_process(false)
		global_position.y = 70
		global_position.x = 320
		shuriken_phase()
		await get_tree().create_timer(10).timeout
		not_shuriken_phase()
		set_physics_process(true)
		move_counter = 0
		return
	
	elif distance_left <= 0.0:
		velocity = Vector2.ZERO
		set_physics_process(false)
		sprite.rotation_degrees = 0
		sprite.play('teleport')
		await get_tree().create_timer(1).timeout
		move_counter += 1
		choose_dash(move_counter)
		return

	var step : float = DASH_SPEED * delta
	step = min(step, distance_left)

	velocity = direction * (step / delta)
	move_and_slide()

	distance_left -= step


func _on_damager_body_entered(body):
	if body == self:
		return	
	if body.has_method("take_damage"):  # Only call receive_hit if the method exists
		body.take_damage()
