extends "res://green_brick.gd"

func hit():
	emit_signal("spawnBrickSignal", "tier2", position)
	emit_signal("score", points)
	emit_signal("popup", points, Color.BLUE, position)
	queue_free()
