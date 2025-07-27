extends Label

func _ready():
	$PopupTimer.start()

func _process(delta: float) -> void:
	position.y -= 1
	
	await $PopupTimer.timeout
	queue_free()
