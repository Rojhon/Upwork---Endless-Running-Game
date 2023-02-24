extends AnimatedSprite

onready var starting_pos: Vector2 = position

func _process(delta):
	position.x += 12
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

