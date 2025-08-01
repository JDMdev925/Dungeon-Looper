extends Node2D

var Enemy = preload("res://Prefabs/Enemy/enemy.tscn")
var InvGrid = load("res://Prefabs/Grid/Grid.cs")


func _ready() -> void:
	InvGrid = InvGrid.new(Vector2(-960, -1588), Vector2(1920, 1080), 2, 2)
	SignalBus.spawn_enemies.connect(SpawnEnemies)


func SpawnEnemies(NextCell : int, Total : int) -> void:
	print(NextCell)
	for i in Total:
		var rng = RandomNumberGenerator.new()
		var pos_x = rng.randf_range(InvGrid.GetCell(NextCell).TopLeft.x + 50, InvGrid.GetCell(NextCell).BottomRight.x - 50)
		var pos_y = rng.randf_range(InvGrid.GetCell(NextCell).TopLeft.y + 50, InvGrid.GetCell(NextCell).BottomRight.y - 50)
		var enemy = Enemy.instantiate()
		set_owner(get_tree().get_root().get_child(1))
		get_tree().current_scene.call_deferred("add_child", enemy)
		enemy.global_position = Vector2(pos_x, pos_y)
		print("Enemy Spawned: ", enemy.global_position)
