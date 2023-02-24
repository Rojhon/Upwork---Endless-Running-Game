extends KinematicBody2D

onready var projectile2: PackedScene = preload("res://Resources/Projectiles/Projectile2.tscn")
var health = 5

func _ready():
	pass

#func _process(delta):
#	Global.instance_node(projectile2, Vector2(position.x, position.y + 86), self)

func _on_Ditection_area_entered(area):
	if area.is_in_group("PlayerProjectile"):
		health -= 1
		
		if health == 0:
			queue_free()
	
	if area.is_in_group("Player"):
		queue_free()

func _on_ShootTimer_timeout():
	Global.instance_node(projectile2, Vector2(position.x - 130, position.y + 86), self)
			

