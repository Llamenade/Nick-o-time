extends Node2D

@onready var shurikensa = $AnimationPlayer

@onready var shuriken1 = $S1
@onready var shuriken2 = $S2
@onready var shuriken3 = $S3

@onready var shuriken1r = $S1/rotate
@onready var shuriken2r = $S2/rotate
@onready var shuriken3r = $S3/rotate

@onready var shuriken1h = $S1/hover
@onready var shuriken2h = $S2/hover
@onready var shuriken3h = $S3/hover

@onready var shuriken1c = $S1/CollisionShape2D
@onready var shuriken2c = $S2/CharacterBody2D
@onready var shuriken3c = $S3/CollisionShape2D

@onready var player = get_parent().get_parent().find_child("Player")

# --------------------------------------------------

var shot := 1

var shuriken1_active := false
var shuriken2_active := false
var shuriken3_active := false

# Player position history (latency trail)
var player_trail: Array[Vector2] = []
const MAX_TRAIL := 30

# All shurikens move at SAME speed
const FOLLOW_SPEED := 0.3

# Delay per shuriken
const SHURIKEN_DATA = {
	1: { "delay": 8 },
	2: { "delay": 13 },
	3: { "delay": 18 }
}

# Bobbing
var bob_time := 0.0
const BOB_FREQUENCY := 4.0

const SHURIKEN_BOB = {
	1: { "amplitude": 8.0 },
	2: { "amplitude": -16.0 },
	3: { "amplitude": 24.0 }
}

# --------------------------------------------------

func _ready():
	shuriken1h.play("hover")
	shuriken2h.play("hover")
	shuriken3h.play("hover")

	shuriken1r.play("rotate")
	shuriken2r.play("rotate")
	shuriken3r.play("rotate")

	# start disabled
	shuriken1c.disabled = true
	shuriken2c.disabled = true
	shuriken3c.disabled = true

# --------------------------------------------------

func _physics_process(delta):
	bob_time += delta

	# record player history
	player_trail.push_front(player.global_position)
	if player_trail.size() > MAX_TRAIL:
		player_trail.pop_back()

	if shuriken1_active:
		_follow_shuriken(shuriken1, 1)

	if shuriken2_active:
		_follow_shuriken(shuriken2, 2)

	if shuriken3_active:
		_follow_shuriken(shuriken3, 3)

# --------------------------------------------------

func _follow_shuriken(shuriken: Node2D, index: int):
	var data = SHURIKEN_DATA[index]
	var bob = SHURIKEN_BOB[index]

	if player_trail.size() <= int(data.delay):
		return

	var target_pos: Vector2 = player_trail[int(data.delay)]

	# identical follow speed for all shurikens
	shuriken.global_position = shuriken.global_position.lerp(
		target_pos,
		FOLLOW_SPEED
	)

	# visual-only sine bob (does not affect speed)
	var amplitude: float = float(bob.amplitude)
	var sin_offset: float = sin(bob_time * BOB_FREQUENCY + float(index)) * amplitude
	shuriken.position.y += sin_offset

# --------------------------------------------------

func reverse():
	shuriken1h.play("hover")
	shuriken2h.play("hover")
	shuriken3h.play("hover")

	# start disabled
	shuriken1c.disabled = true
	shuriken2c.disabled = true
	shuriken3c.disabled = true
	shuriken1_active = false
	shuriken2_active = false
	shuriken3_active = false
	shot = 1
	

func shoot():
	if shot == 1:
		shuriken1h.stop()
		shuriken1c.disabled = false
		shuriken1_active = true
		shot += 1

	elif shot == 2:
		shuriken2h.stop()
		shuriken2c.disabled = false
		shuriken2_active = true
		shot += 1

	elif shot == 3:
		shuriken3h.stop()
		shuriken3c.disabled = false
		shuriken3_active = true
		shot += 1


func _on_s_1_body_entered(body):
	if body == self:
		return	
	if body.has_method("take_damage"):  # Only call receive_hit if the method exists
		body.take_damage()


func _on_s_2_body_entered(body):
	if body == self:
		return	
	if body.has_method("take_damage"):  # Only call receive_hit if the method exists
		body.take_damage()


func _on_s_3_body_entered(body):
	if body == self:
		return	
	if body.has_method("take_damage"):  # Only call receive_hit if the method exists
		body.take_damage()
