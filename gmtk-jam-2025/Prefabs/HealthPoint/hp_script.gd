extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		pass
	else:
		SignalBus.heart_hit.emit(body)
		SignalBus.enemy_hit.emit()
		queue_free()
