extends CharacterBody2D

func _on_hit(body):
	if body == self:
		return
		
	if body.has_method("take_damage"):  # Only call receive_hit if the method exists
		body.take_damage()
