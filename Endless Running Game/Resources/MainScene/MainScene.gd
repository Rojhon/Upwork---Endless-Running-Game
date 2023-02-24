extends Node2D

var is_start = false

onready var control: Control = get_node(("Control"))
onready var score: Label = get_node("Control/Score")
onready var score_timer: Timer = get_node("ScoreTimer")

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
onready var env5: PackedScene = preload("res://Resources/Environment/Env5.tscn")

onready var environments: Array = [env1, env2, env2, env3, env1, env2, env3, env5]

func _ready():
	shoot_timer.start()

func _process(delta):
	score.text = str(Global.score)
	# Player start
	if Input.is_action_just_pressed("jump") and is_start == false and player.health != 0:
		is_start = true
		score_timer.start()
		$TutorialControl.hide()
		
	if is_start == true:
		control.rect_position.x = $Position2D.position.x
	
	if is_start == true:
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
		
		if player.position.x > environments_node.get_child(environments_node_size - 1).position.x - 1000:
			var pos = environments_node.get_child(environments_node_size - 1).position
			
			randomize()
			var rand_index:int = randi() % environments.size()
			
			Global.instance_node(environments[rand_index], Vector2(pos.x + rand_range(500, 520), pos.y), environments_node)
		
			if environments_node.get_child_count() == 6:
				environments_node.get_child(0).queue_free()

func _on_ShootTimer_timeout():
	if is_start == true:
		Global.instance_node(projectile1, player.position, projectiles_node)


func _on_ScoreTimer_timeout():
	if player.health != 0:
		Global.score += 1


func _on_PlayAgain_pressed():
	Global.score = 0
	get_tree().reload_current_scene()
