extends Node2D

var trigger : bool = false

func _ready() -> void:
	SignalBus.gate_command.connect(OnActivate)

func OnActivate(body: Node2D, num: int) -> void:
	if body == null and trigger == false:
		SignalBus.enemy_hit.emit()
		trigger = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		pass
	else:
		SignalBus.heart_hit.emit(body)
		if trigger == false:
			SignalBus.enemy_hit.emit()
		queue_free()
