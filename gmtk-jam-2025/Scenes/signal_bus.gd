extends Node

signal bullet_hit(target : Node2D)
signal p_bullet_hit(target : Node2D)
signal player_hit()
signal gunshot(reload : float, mag : int)
signal enemy_hit()
signal enemy_activate()
signal update_grid(cellnum : int)
signal spawn_enemies(nextcell : int, total : int)
signal gate_command(gate: Node2D, state: int)

var gate_dict : Dictionary[int, Node2D] = {}
var NextCell : int
var PlayerHealth : int = 4
var EnemyCount : int  = 0
var Level : int = 1
var Progress : int = 0

func LoseLife() -> void:
	PlayerHealth -= 1
	if PlayerHealth <= 0:
		get_tree().change_scene_to_file.call_deferred("res://Scenes/GameOver/GOScreen.tscn")

func EnemyKilled() -> void:
	EnemyCount -= 1
	if EnemyCount <= 0:
		UpdateDifficulty()
		gate_command.emit(gate_dict[NextCell], 0)
		spawn_enemies.emit(NextCell, Level)
		EnemyCount = Level

func UpdateDifficulty() -> void:
	Progress += 1
	if Progress >= 4:
		Progress = 0
		Level += 1

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
