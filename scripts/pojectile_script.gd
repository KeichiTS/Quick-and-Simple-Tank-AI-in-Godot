extends Spatial

# Creates & uses a projectile

class_name Projectile

export(float) var damage = 5

func fire(dir):
	$RigidBody.apply_impulse(Vector3.ZERO, dir * 8)
	$RigidBody.connect("body_entered", self, "on_body_entered")

func _on_Timeout_timeout():
	queue_free()

func on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()


func _on_Lifespan_timeout():
	queue_free()
