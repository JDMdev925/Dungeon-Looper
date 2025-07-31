extends Camera2D

@export var TOTAL_ROWS : int
@export var TOTAL_COLLUMNS : int
@export var CELL_SIZE : Vector2
@export var STARTING_CELL : int
@export var ANCHOR_POINT : Vector2
@export_enum ("Linear", "Smooth") var MOTION_TYPE : String = "Smooth"


var Grid = load("res://Prefabs/Grid/Grid.cs")
var CameraGrid 
var CurrentCell : int
var PlayerTopLeft : Vector2
var PlayerBottomRight : Vector2
@onready var Player = $"../CharacterBody2D"

var transition : bool = false

func SmoothInterpolate(progress: float) -> float:
	if progress < 0.5:
		progress = 8 * progress * progress * progress
	else:
		progress = 1 - pow(-2 * progress + 2, 4) / 2
	return progress

func LERP(start: Vector2, end: Vector2, time: float) -> Vector2:
	return start * (1 - time) + end * time


func IdentifyNewCell(current: int) -> int:
	var HoldCell = current
	if (Player.position.x > CameraGrid.GetCell(CurrentCell).BottomRight.x):
		current += 1
	if (Player.position.x < CameraGrid.GetCell(CurrentCell).TopLeft.x):
		current -= 1
	if (Player.position.y > CameraGrid.GetCell(CurrentCell).BottomRight.y):
		current += TOTAL_ROWS
	if (Player.position.y < CameraGrid.GetCell(CurrentCell).TopLeft.y):
		current -= TOTAL_ROWS
	else:
		pass
	if current > CameraGrid.GridSize:
		current = HoldCell

	return current

func MoveToNewCell() -> void: 
	var point : float = 0.0
	if MOTION_TYPE == "Smooth":
		point = SmoothInterpolate(1 - $Timer.time_left)
	else:
		point = 1 - $Timer.time_left
	global_position = LERP(global_position, CameraGrid.GetCell(CurrentCell).Centre, point * 0.05)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CameraGrid = Grid.new(ANCHOR_POINT, CELL_SIZE, TOTAL_ROWS, TOTAL_COLLUMNS)
	CurrentCell = STARTING_CELL
	global_position = CameraGrid.GetCell(STARTING_CELL).Centre


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var BufferCell = CurrentCell
	if transition == false:
		CurrentCell = IdentifyNewCell(CurrentCell)
		
		if BufferCell != CurrentCell:
			$Timer.start(1)
			SignalBus.UpdateGrid(CurrentCell)
			transition = true
	elif transition == true:
		MoveToNewCell()
		
	
	


func _on_timer_timeout() -> void:
	transition = false
