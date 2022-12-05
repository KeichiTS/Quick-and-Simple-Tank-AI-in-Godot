extends Spatial

# Moves a tank to a specified path

class_name Mover

signal on_finished_moving

export(float) var move_speed = 5

var path = []
var path_index = 9999
var tank: KinematicBody
var tank_mesh: Spatial

func _ready():
	tank = $".."
	tank_mesh = $"../TankMesh"
	
func _process(delta):
	pass

func _physics_process(delta):
	if path == null:
		return
		
	if path_index < path.size():
		var move_vec = (path[path_index] - tank.global_transform.origin)

		if move_vec.length() < 0.1:
			path_index += 1
		else:
			tank.move_and_slide(move_vec.normalized() * move_speed, Vector3(0, 1, 0))
			tank_mesh.look_at(path[path_index], Vector3.UP)
			
		if path_index >= path.size():
			emit_signal("on_finished_moving")

func set_path(new_path):
	path = new_path
	path_index = 0
	
func reset():
	path = []
	path_index = 0
	
func has_finished_path():
	if path == null:
		return true
		
	return path_index >= path.size()
