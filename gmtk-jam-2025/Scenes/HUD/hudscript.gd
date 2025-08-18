extends CanvasLayer

var reloading : bool
var hearts : int = 2
var time : float = 0

func _ready() -> void:
	SignalBus.gunshot.connect(UpdateHud)
	SignalBus.player_hit.connect(ReduceHearts)
	SignalBus.gain_life.connect(IncreaseHearts)
	$TextureProgressBar.value = 100


func UpdateHud(reload : float, mag : int) -> void:
	if reload > 0:
		$TextureProgressBar/Timer.start(reload)
		$TextureProgressBar/LineEdit.text = "R"
		reloading = true
		$GunReloadSFX.play()
	else:
		$TextureProgressBar.value = (mag * 10)
		$TextureProgressBar/LineEdit.text = str(mag)
		#print("VALUE", mag)

func ReduceHearts() -> void:
	if hearts < 0:
		hearts = 0
	var Sprite : Sprite2D = $Health.get_child(hearts)
	Sprite.frame = 2
	hearts -= 1

func IncreaseHearts() -> void:
	if hearts >= 2:
		hearts = 2
	else:
		hearts += 1
	var Sprite : Sprite2D = $Health.get_child(hearts)
	Sprite.frame = 0
	$HeartGainSFX.play()



func _process(delta: float) -> void:
	if reloading:
		$TextureProgressBar.value = lerp(0, 100, 2 - $TextureProgressBar/Timer.time_left)
	time += delta
	UpdateStopwatch()
	

func UpdateStopwatch() -> void:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var mmin = time / 60
	
	var format = "%02d : %02d : %03d"
	$Stopwatch.text = format % [mmin, sec, msec]

func _on_timer_timeout() -> void:
	reloading = false
	$GunReloadSFX.stop()
