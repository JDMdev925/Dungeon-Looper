extends Node

signal bullet_hit(target : Node2D)
signal p_bullet_hit(target : Node2D)
signal player_hit()
signal gunshot(reload : float, mag : int)
signal enemy_hit()
signal update_grid(cellnum : int)
signal spawn_enemies(nextcell : int, total : int)
signal gate_command(gate: Node2D, state: int)

var gate_dict : Dictionary[int, Node2D] = {}
var NextCell : int
var PlayerHealth : int = 3
var EnemyCount : int  = 0

func LoseLife() -> void:
	PlayerHealth -= 1
	if PlayerHealth <= 0:
		get_tree().change_scene_to_file("res://Scenes/GameOver/GOScreen.tscn")

func EnemyKilled() -> void:
	EnemyCount -= 1
	if EnemyCount <= 0:
		gate_command.emit(gate_dict[NextCell], 0)
		spawn_enemies.emit(NextCell, 1)
		EnemyCount = 1

func UpdateGrid(cellnum : int):
	
	match cellnum:
		0:
			NextCell = 1
		1:
			NextCell = 3
		3:
			NextCell = 2
		2:
			NextCell = 0
		_:
			NextCell = 0



func _ready() -> void:
	player_hit.connect(LoseLife)
	enemy_hit.connect(EnemyKilled)
	update_grid.connect(UpdateGrid)
	NextCell = 0
