extends CharacterBody2D

const bullet_speed : float = 600.0

func _process(delta: float) -> void:
	position += transform.x * bullet_speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("NoImpact"):
		pass
	else:
		#print(body.name)
		SignalBus.bullet_hit.emit(body)
		queue_free()
