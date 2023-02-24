extends Node

var score:int = 0
var highscore_file = "user://highscore.save"
var highscore = 0

func _ready():
	var save_game = File.new()
	if save_game.file_exists(highscore_file):
		var file = File.new()
		if file.open(highscore_file, File.READ) == OK:
			highscore = int(file.get_line())
			file.close()
	else:
		highscore = 0

func save_highscore(new_score):
	if new_score > highscore:
		highscore = new_score
		var file = File.new()
		if file.open(highscore_file, File.WRITE) == OK:
			file.store_line(str(highscore))
			file.close()
		else:
			print("Failed to open highscore file for writing.")
			
func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.position = location
