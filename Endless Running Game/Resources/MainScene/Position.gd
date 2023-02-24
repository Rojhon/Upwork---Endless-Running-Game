extends Position2D


func _process(delta):
	if get_parent().is_start == true:
		position.x += 5
		get_parent().get_node("Player").position.x += 5
