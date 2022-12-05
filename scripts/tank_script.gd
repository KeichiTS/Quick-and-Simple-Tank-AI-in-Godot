extends KinematicBody

onready var nav = $".."
onready var mover: Mover = $Mover
onready var detector: Detector = $Detector
onready var sm = $StateMachinePlayer

var is_patrol_wait = false
var is_seeking_targets = false

func _ready():
	sm.connect("updated", self, "on_sm_update")
	sm.connect("transited", self, "on_sm_transition")

	mover.connect("on_finished_moving", self, "on_finished_moving")


func _process(delta):
	sm.set_param("is_patrol_wait", is_patrol_wait)
	sm.set_param("is_seeking_targets", is_seeking_targets)
	
	if Input.is_action_just_pressed("trigger_seeking"):
		is_seeking_targets = !is_seeking_targets

func on_sm_update(state,delta):
	match state:
		"SEEK_TARGET":
			if mover.has_finished_path():
				mover.set_path(get_target_path())
	
func on_sm_transition(from_state , to_state):
	match to_state:
		"PATROL":
			mover.set_path(generate_random_position())
		"PATROL_WAIT":
			$PatrolWait.start()
		
func generate_random_position():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var pos_x = global_transform.origin.x + rng.randf_range(-2,2)
	var pos_z = global_transform.origin.z + rng.randf_range(-2,2)
	
	var target_position = Vector3(pos_x, -0.193868, pos_z)
	
	var path = nav.get_simple_path(global_transform.origin, target_position)
	return path

func on_finished_moving():
	is_patrol_wait = true


func _on_PatrolWait_timeout():
	is_patrol_wait = false

func get_target_path():
	var current_target = detector.get_current_target()
	
	if current_target == null:
		return
	var path = nav.get_simple_path(global_transform.origin, current_target.global_transform.origin)
	
	return path
