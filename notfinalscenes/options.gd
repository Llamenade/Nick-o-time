extends TextureRect


@onready var headoptions = $HeadOptions
@onready var charmoptions = $CharmOptions

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.part_selected == 'Head':
		headoptions.z_index = 1
		headoptions.show()
	else:
		headoptions.z_index = -5
		headoptions.hide()
	if Global.part_selected == 'Charm':
		charmoptions.z_index = 1
		charmoptions.show()
	else:
		charmoptions.z_index = -5
		charmoptions.hide()
