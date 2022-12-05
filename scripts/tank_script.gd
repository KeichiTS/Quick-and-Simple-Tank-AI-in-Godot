extends KinematicBody

onready var nav = get_parent()
onready var mover : Mover = $Mover
onready var sm = $StateMachinePlayer

func ready():
	sm.connect("updated", self, "on_sm_update")
	sm.connect("transited", self, "on_sm_transition")

func _ready():
	pass

func _process(delta):
	pass

func on_sm_update(state,delta):
	pass
	
func on_sm_transition(from_state,to_state):
	match to_state:
		"PATROL":
			mover.set_path(generate_random_position())
		
func generate_random_position():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var pos_x = global_transform.origin.x + rng.randf_range(-2,2)
	var pos_z = global_transform.origin.z + rng.randf_range(-2,2)
	
	var target_position = Vector3(pos_x, -0.193868, pos_z)
	
	var path = nav.get_simple_path(global_transform.origin, target_position)
	
	return path
