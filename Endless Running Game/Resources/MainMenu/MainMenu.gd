extends Node2D


func _ready():
	$Control/HighScore.text += " " + str(Global.highscore)

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Resources/MainScene/MainScene.tscn")
