extends State

func enter():
	owner.position.x = 320
	owner.position.y = 10
	owner.set_physics_process(false)
