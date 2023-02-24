extends Node

var score:int = 0
var highscore:int = 0

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.position = location
