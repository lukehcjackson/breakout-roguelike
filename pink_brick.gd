extends "res://purple_brick.gd"

func hit():
	emit_signal("spawnBrickSignal", "tier4", position)
	emit_signal("score", points)
	emit_signal("popup", points, Color.DEEP_PINK, position)
	queue_free()
