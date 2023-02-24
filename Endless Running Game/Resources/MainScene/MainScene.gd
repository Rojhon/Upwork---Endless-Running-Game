extends Node2D

var is_start = false

onready var player: KinematicBody2D = get_node("Player")
onready var projectiles_node: Node = get_node("Projectiles")
onready var projectile1: PackedScene = preload("res://Resources/Projectiles/Projectile1.tscn")
onready var shoot_timer: Timer = get_node("ShootTimer")

onready var backgrounds_node: Node2D = get_node("Backgrounds")
onready var bg1: PackedScene = preload("res://Resources/Background/Bg1.tscn")

onready var environments_node: Node2D = get_node("Environments")
onready var test_environment: PackedScene = preload("res://Resources/Environment/TestEnvironment.tscn")
onready var env1: PackedScene = preload("res://Resources/Environment/Env1.tscn")
onready var env2: PackedScene = preload("res://Resources/Environment/Env2.tscn")
onready var env3: PackedScene = preload("res://Resources/Environment/Env3.tscn")
onready var env4: PackedScene = preload("res://Resources/Environment/Env4.tscn")

onready var environments: Array = [env1, env2, env3, env4]

var pos_x = 700

func _ready():
	shoot_timer.start()

func _process(delta):
	# Player start
	if Input.is_action_just_pressed("jump") and is_start == false:
		is_start = true
	
	# Background Spawn
	var backgrounds_node_size = backgrounds_node.get_child_count()
	
	if player.position.x > backgrounds_node.get_child(backgrounds_node_size - 1).position.x:
		var pos = backgrounds_node.get_child(backgrounds_node_size - 1).position
#		environments_node.get_child(0).queue_free()
		Global.instance_node(bg1, Vector2(pos.x + 3407, pos.y), backgrounds_node)
	
		if backgrounds_node.get_child_count() == 5:
			backgrounds_node.get_child(0).queue_free()
	
	# Environments spawn
	var environments_node_size = environments_node.get_child_count()
	
	if player.position.x > environments_node.get_child(environments_node_size - 1).position.x - 300:
		var pos = environments_node.get_child(environments_node_size - 1).position
		
		randomize()
		var rand_index:int = randi() % environments.size()
		
		Global.instance_node(environments[rand_index], Vector2(pos.x + pos_x, pos.y), environments_node)
		
		if rand_index == 0:
			pos_x = 700
		elif rand_index == 1:
			pos_x = 500
		elif rand_index == 2 || rand_index == 3:
			pos_x = 550
	
		if environments_node.get_child_count() == 6:
			environments_node.get_child(0).queue_free()
	
	

func _on_ShootTimer_timeout():
	if is_start == true:
		Global.instance_node(projectile1, player.position, projectiles_node)
