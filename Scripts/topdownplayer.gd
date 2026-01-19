extends CharacterBody2D

@onready var head = $Head
@onready var torso = $Torso
@onready var legs = $Legs

func _ready():
	#initiate correctly
	head.play(Global.current_head + "idle")
	torso.play("idle")
	legs.play("idle")
	
func _physics_process(delta):
	if Input.is_action_pressed("left") and Input.is_action_pressed("up"):
		head.play(Global.current_head + "leftup")
		torso.play("leftup")
		legs.play("leftup")
	elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
		head.play(Global.current_head + "rightup")
		torso.play("rightup")
		legs.play("rightup")
	elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
		head.play(Global.current_head + "leftdown")
		torso.play("leftdown")
		legs.play("leftdown")
	elif Input.is_action_pressed("right") and Input.is_action_pressed("down"):
		head.play(Global.current_head + "rightdown")
		torso.play("rightdown")
		legs.play("rightdown")
	elif Input.is_action_pressed("right"):
		head.play(Global.current_head + "right")
		torso.play("right")
		legs.play("right")
	elif Input.is_action_pressed("left"):
		head.play(Global.current_head + "left")
		torso.play("left")
		legs.play("left")
	elif Input.is_action_pressed("down"):
		head.play(Global.current_head + "down")
		torso.play("down")
		legs.play("down")
	elif Input.is_action_pressed("up"):
		head.play(Global.current_head + "up")
		torso.play("up")
		legs.play("up")
	elif Global.is_loadout_screen_visible == true:
		head.play(Global.current_head + "idle")
		torso.play("idle")
		legs.play("idle")
	else:
		head.stop()
		torso.stop()
		legs.stop()
