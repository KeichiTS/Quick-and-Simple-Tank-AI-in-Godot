extends Node

# Detects the objects registered in the group "targets"

class_name Detector

var current_target = null

func _process(delta):
	var targets = get_tree().get_nodes_in_group("targets")
	
	for target in targets:
		if target == null or is_instance_valid(target) == false:
			continue
		current_target = target
		return

func get_current_target():
	if current_target == null or is_instance_valid(current_target) == false:
		return null
	return current_target
