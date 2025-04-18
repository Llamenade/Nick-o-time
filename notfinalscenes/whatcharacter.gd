extends RichTextLabel

func _process(delta: float) -> void:
	if Global.nikotime:
		self.text = "Nick O. Time"
	elif Global.justintime:
		self.text = "Justin Time"
	elif Global.archytime:
		self.text = "Archy Time"
	elif Global.chilltime:
		self.text = "Chill Time"
	elif Global.oogatime:
		self.text = "Ooga Time"
	elif Global.minotime:
		self.text = "Mino Time"
	elif Global.caesartime:
		self.text = "Caesar Time"
	elif Global.sirtime:
		self.text = "Sir Time"
	elif Global.echotime:
		self.text = "Echo Time"
	elif Global.acetime:
		self.text = "Ace Time"
	elif Global.privatetime:
		self.text = "Private Time"
	elif Global.tinatime:
		self.text = "Tina Time"
	elif Global.martiantime:
		self.text = "Martian Time"
	elif Global.demontime:
		self.text = "Demon Time"
