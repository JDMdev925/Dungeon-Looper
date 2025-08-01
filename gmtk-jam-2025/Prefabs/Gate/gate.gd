extends StaticBody2D

enum STATE {OPEN, CLOSE}
@export var State : STATE = STATE.CLOSE
@export var Room : int = 0


func UpdateState(gate: Node2D, state: int) -> void:
	if gate == self or gate == null:
		match state:
			0:
				State = STATE.OPEN
			1:
				State = STATE.CLOSE
			_:
				State = STATE.CLOSE
		ChangeState()
	else:
		pass

func ChangeState() -> void:
	if State == STATE.OPEN:
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		print("open")
	elif State == STATE.CLOSE:
		visible = true
		$CollisionShape2D.disabled = false
		print("close")

func _ready() -> void:
	SignalBus.gate_command.connect(UpdateState)
	SignalBus.gate_dict[Room] = self
	ChangeState()
