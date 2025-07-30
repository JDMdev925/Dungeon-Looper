extends CharacterBody2D


const SPEED = 600.0
var Gun = load("res://Prefabs/Gun/Gun.cs")
var Bullet = preload("res://Prefabs/Bullet/bullet.tscn")

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

func _ready() -> void:
	Gun = Gun.new(2.0, 10, 1)

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	Movement()
	if Input.is_action_just_pressed("Shoot"):
		var bullet = Bullet.instantiate()
		set_owner(get_tree().get_root().get_child(0))
		owner.add_child(bullet)
		bullet.position = $Marker2D.global_position
		bullet.rotation = $Marker2D.global_rotation
