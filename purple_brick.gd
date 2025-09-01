extends "res://blue_brick.gd"

func hit():
	emit_signal("spawnBrickSignal", "tier3", position)
	emit_signal("score", points)
	emit_signal("popup", points, Color.PURPLE, position)
	queue_free()
