extends CharacterBody2D


@onready var Player = $"../CharacterBody2D"
var Enemy
var InArea : bool = false
var InTerritory : bool = false
@export var active : bool = false

func Activate() -> void:
	active = true


func _ready() -> void:
	add_to_group("Enemies")
	SignalBus.bullet_hit.connect(_on_bullet_hit)
	SignalBus.enemy_activate.connect(Activate)


func _process(delta: float) -> void:
	if active:
		look_at(Player.position)
		if InTerritory:
			global_position += -position.direction_to(Enemy.position) * delta * 200
		
		if !InArea and !InTerritory:
			#global_position = position.move_toward(Player.position, 200 * delta)
			velocity = position.direction_to(Player.position) * 300
			move_and_slide()
		else:
			$Gun.on_shoot(1)


func _on_bullet_hit(target: Node2D) -> void:
	if target == self:
		SignalBus.enemy_hit.emit()
		queue_free()

func _on_player_sphere_body_entered(body: Node2D) -> void:
	if body == Player:
		InArea = true

func _on_enemy_sphere_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies") and body.name != name:
		InTerritory = true
		Enemy = body

func _on_enemy_sphere_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemies") and body.name != name:
		InTerritory = false

func _on_player_sphere_body_exited(body: Node2D) -> void:
	if body == Player:
		InArea = false
