extends Node2D

onready var projectile2: PackedScene = preload("res://Resources/Projectiles/Projectile2.tscn")

func _ready():
	pass

func _on_ShootTimer_timeout():
	pass
#	Global.instance_node(projectile2, $Enemy1.position, get_parent().get_parent().get_node("Projectiles"))
