extends "res://red-brick.gd"

func hit():
	emit_signal("spawnBrickSignal", "layer1", position)
	emit_signal("score", points)
	emit_signal("popup", points, Color.GREEN, position)
	queue_free()
