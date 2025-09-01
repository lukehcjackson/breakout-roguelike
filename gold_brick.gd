extends "res://pink_brick.gd"

signal increaseMult()

func hit():
	emit_signal("spawnBrickSignal", "tier5", position)
	increaseMult.emit()
	emit_signal("score", points)
	emit_signal("popup", points, Color.GOLD, position)
	queue_free()
