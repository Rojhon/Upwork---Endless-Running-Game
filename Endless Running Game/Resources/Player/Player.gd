extends KinematicBody2D

export (int) var speed = 5
export (int) var jump_speed = -1000
export (int) var jump_count = 1
export (int) var gravity = 4000

var velocity = Vector2.ZERO

onready var main_scene = get_parent()
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var health = 3

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if main_scene.is_start == true:
		position.x += speed
		if Input.is_action_just_pressed("jump") and jump_count != 0:
			animated_sprite.play("jump")
			jump_count -= 1
			velocity.y = jump_speed
		
		if is_on_floor():
			jump_count = 1
		
		if velocity.y == 0:	
			animated_sprite.play("run")
		


func _on_Ditection_area_entered(area):
	if area.is_in_group("Fall"):
		health -= 1
