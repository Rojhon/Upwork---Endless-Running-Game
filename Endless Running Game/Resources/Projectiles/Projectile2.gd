extends AnimatedSprite

onready var starting_pos: Vector2 = position

func _process(delta):
	position.x -= 5
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		queue_free()
