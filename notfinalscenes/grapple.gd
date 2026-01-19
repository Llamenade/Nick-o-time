extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var player: Node2D = get_parent()

@export var max_distance := 2000.0
@export var extend_speed := 800   # pixels per second
@export var pull_speed := 900     # pixels per second
@export var detach_distance := 40 # pixels, auto-detach threshold

var base_width := 0.0
var grapple_point := Vector2.ZERO
var progress := 0.0    # 0 = start, 1 = fully extended

var extending := false
var pulling := false

@onready var retract_sound = $retract


func _ready():
	base_width = sprite.texture.get_width()
	_hide_rope()


func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_RIGHT \
	and event.pressed and Global.current_charm == 'tapemeasurer':
		fire()


func fire():
	retract_sound.play()
	_hide_rope()

	var start := player.global_position
	var dir := (get_global_mouse_position() - start).normalized()

	var hit := _raycast(start, dir)
	if hit.is_empty():
		return

	grapple_point = hit.position
	progress = 0.0
	extending = true
	set_physics_process(true)
	


func _physics_process(delta):
	var start := player.global_position

	if extending:
		# Animate rope extension
		var total_distance := start.distance_to(grapple_point)
		progress += extend_speed * delta / total_distance
		progress = min(progress, 1.0)

		_draw_rope(start, grapple_point, progress)

		if progress >= 1.0:
			extending = false
			pulling = true
		return

	if pulling:
		var to_target := grapple_point - start
		var distance := to_target.length()

		# 🔹 Auto-detach if player is close enough
		if distance <= detach_distance:
			_disconnect()
			return

		# Pull player toward tip
		player.global_position += to_target.normalized() * pull_speed * delta
		_draw_rope(start, grapple_point, 1.0)


func _draw_rope(start: Vector2, end: Vector2, t: float):
	var current_end := start.lerp(end, t)
	var vec := current_end - start

	global_position = start
	rotation = vec.angle()

	var length := vec.length()
	sprite.scale.x = max(length / base_width, 0.001)
	sprite.position.x = length * 0.5


func _disconnect():
	# 🔹 Stop pulling and reset rope
	pulling = false
	extending = false
	set_physics_process(false)
	_hide_rope()
	retract_sound.stop()


func _raycast(origin: Vector2, dir: Vector2) -> Dictionary:
	var query := PhysicsRayQueryParameters2D.create(
		origin,
		origin + dir * max_distance
	)
	query.exclude = [self, player]
	return get_world_2d().direct_space_state.intersect_ray(query)


func _hide_rope():
	sprite.scale.x = 0.001
	sprite.position.x = 0.0
