extends Node

signal bullet_hit(target : Node2D)
signal p_bullet_hit(target : Node2D)
signal player_hit()
signal update_grid(cellnum : int)
signal spawn_enemies(nextcell : int, total : int)

var NextCell : int

func LoseLife():
	pass

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
	spawn_enemies.emit(NextCell, 1)



func _ready() -> void:
	player_hit.connect(LoseLife)
	update_grid.connect(UpdateGrid)
	NextCell = 0
