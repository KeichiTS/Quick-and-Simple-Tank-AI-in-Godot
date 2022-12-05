extends Spatial

# Used to define the HP of a target

export(float) var HP = 20

var is_alive = true

func _ready():
	add_to_group("targets")

func take_damage(damage):
	HP -= damage

	if HP <= 0 and is_alive == true:
		is_alive = false
		queue_free()
