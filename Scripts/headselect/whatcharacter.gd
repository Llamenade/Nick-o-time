extends RichTextLabel

func _process(delta: float) -> void:
	if Global.current_head == 'niko':
		self.text = "Nick O. Time"
	elif Global.current_head == 'justin':
		self.text = "Justin Time"
	elif Global.current_head == 'archy':
		self.text = "Archy Time"
	elif Global.current_head == 'chill':
		self.text = "Chill Time"
	elif Global.current_head == 'ooga':
		self.text = "Ooga Time"
	elif Global.current_head == 'mino':
		self.text = "Mino Time"
	elif Global.current_head == 'caesar':
		self.text = "Caesar Time"
	elif Global.current_head == 'sir':
		self.text = "Sir Time"
	elif Global.current_head == 'echo':
		self.text = "Echo Time"
	elif Global.current_head == 'ace':
		self.text = "Ace Time"
	elif Global.current_head == 'private':
		self.text = "Private Time"
	elif Global.current_head == 'tina':
		self.text = "Tina Time"
	elif Global.current_head == 'martian':
		self.text = "Martian Time"
	elif Global.current_head == 'demon':
		self.text = "Demon Time"
