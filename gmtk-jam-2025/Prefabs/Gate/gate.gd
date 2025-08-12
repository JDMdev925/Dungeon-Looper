extends StaticBody2D

enum STATE {OPEN, CLOSE}
enum ALIGNMENT {HORIZONTAL, VERTICAL}
@export var Alignment : ALIGNMENT = ALIGNMENT.HORIZONTAL
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
		if Alignment == ALIGNMENT.HORIZONTAL:
			$Sprite2D.frame = 1
		elif Alignment == ALIGNMENT.VERTICAL:
			$Sprite2D.frame = 3
		$CollisionShape2D.set_deferred("disabled", true)
		#print("open")
	elif State == STATE.CLOSE:
		if Alignment == ALIGNMENT.HORIZONTAL:
			$Sprite2D.frame = 0
		elif Alignment == ALIGNMENT.VERTICAL:
			$Sprite2D.frame = 2
		$CollisionShape2D.disabled = false
		#print("close")
	


func _ready() -> void:
	SignalBus.gate_command.connect(UpdateState)
	SignalBus.gate_dict[Room] = self
	ChangeState()
