extends AnimatedSprite2D

func _process(delta):
	
	if Global.using_controller:
		self.play("pressa")
	else:
		self.play("presse")
