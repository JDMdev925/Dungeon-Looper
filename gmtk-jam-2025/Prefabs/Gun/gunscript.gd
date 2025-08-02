extends Marker2D

var Gun = load("res://Prefabs/Gun/Gun.cs")
var Bullet = preload("res://Prefabs/Bullet/bullet.tscn")
var P_Bullet = preload("res://Prefabs/Bullet/p_bullet.tscn")
var Reloading : bool = false
var type : int = 0

@export var RateOfFire : float = 0.8
@export var MagSize : int = 10
@export var BulletsPerShot : int = 1
@export var ReloadSpeed : float = 5

func _ready() -> void:
	Gun = Gun.new(RateOfFire, MagSize, BulletsPerShot, ReloadSpeed)

func on_shoot(mode: int) -> void:
	type = mode
	if Gun.Mag > 0:
		if $FireRate.time_left == 0:
			$FireRate.start(Gun.ROF)
			print("fire")
		else:
			pass
	else:
		if Reloading == false:
			reload()
			print("reloading")
		else:
			pass


func reload() -> void:
	$Cooldown.start(Gun.CoolDown)
	Reloading = true
	SignalBus.gunshot.emit(Gun.CoolDown, 0)


func _on_fire_rate_timeout() -> void:
	#print("bullet")
	for i in Gun.BPS:
		var bullet
		if type == 0:
			bullet = Bullet.instantiate()
			SignalBus.gunshot.emit(0, Gun.Mag - 1)
		else:
			bullet = P_Bullet.instantiate()
		set_owner(get_tree().get_root().get_child(1))
		owner.add_child(bullet)
		bullet.position = global_position
		bullet.rotation = global_rotation
	Gun.Mag -= 1
	$AudioStreamPlayer2D.play()
	$Cooldown.stop()


func _on_cooldown_timeout() -> void:
	Gun.Mag = Gun.MagSize
	SignalBus.gunshot.emit(0, Gun.Mag)
	print("reloaded")
	Reloading = false
