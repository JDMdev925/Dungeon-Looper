extends CanvasLayer

var reloading : bool

func _ready() -> void:
	SignalBus.gunshot.connect(UpdateHud)
	$TextureProgressBar.value = 100


func UpdateHud(reload : float, mag : int) -> void:
	if reload > 0:
		$TextureProgressBar/Timer.start(reload)
		$TextureProgressBar/TextEdit.text = "R"
		reloading = true
	else:
		$TextureProgressBar.value = (mag * 10)
		$TextureProgressBar/TextEdit.text = str(mag)
		#print("VALUE", mag)


func _process(delta: float) -> void:
	if reloading:
		$TextureProgressBar.value = lerp(0, 100, 2 - $TextureProgressBar/Timer.time_left)


func _on_timer_timeout() -> void:
	reloading = false
