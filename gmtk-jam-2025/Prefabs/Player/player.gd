extends CharacterBody2D


const SPEED = 800.0



func Movement() -> void:
	var horizontal := Input.get_axis("Left", "Right")
	var vertical := Input.get_axis("Up", "Down")
	
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func _on_bullet_hit(target : Node2D) -> void:
	if target == self:
		SignalBus.player_hit.emit()

func _ready() -> void:
	SignalBus.p_bullet_hit.connect(_on_bullet_hit)

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	Movement()
	
	if Input.is_action_just_pressed("Shoot"):
		$Gun.on_shoot(0)
