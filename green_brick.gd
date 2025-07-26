extends "res://red-brick.gd"

func hit():
	print("hit da green brick")
	emit_signal("spawnBrickSignal", "layer1", position)
	emit_signal("score", points)
	queue_free()
