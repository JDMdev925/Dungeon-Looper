extends Node2D

var Enemy = preload("res://Prefabs/Enemy/enemy.tscn")
var HP = preload("res://Prefabs/HealthPoint/health_point.tscn")
var InvGrid = load("res://Prefabs/Grid/Grid.cs")
var add_health : bool = false

func _ready() -> void:
	InvGrid = InvGrid.new(Vector2(-960, -1588), Vector2(1920, 1080), 2, 2)
	SignalBus.spawn_enemies.connect(SpawnEnemies)


func SpawnEnemies(NextCell : int, Total : int) -> void:
	print(NextCell)
	
	var coin = RandomNumberGenerator.new()
	var result = coin.randi_range(0, 3)
	if result == 1:
		add_health = true
	else:
		add_health = false
	
	for i in Total:
		var rng = RandomNumberGenerator.new()
		var pos_x = rng.randf_range(InvGrid.GetCell(NextCell).TopLeft.x + 150, InvGrid.GetCell(NextCell).BottomRight.x - 150)
		var pos_y = rng.randf_range(InvGrid.GetCell(NextCell).TopLeft.y + 150, InvGrid.GetCell(NextCell).BottomRight.y - 150)
		var enemy
		if add_health == true:
			enemy = HP.instantiate()
			add_health = false
		else:
			enemy = Enemy.instantiate()
		set_owner(get_tree().get_root().get_child(1))
		get_tree().current_scene.call_deferred("add_child", enemy)
		enemy.global_position = Vector2(pos_x, pos_y)
		print("Enemy Spawned: ", enemy.global_position)
	
