extends State

func enter():
	super.enter()
	owner.start_dash()
	
	
func exit():
	super.exit()
	owner.set_physics_process(false)
	
