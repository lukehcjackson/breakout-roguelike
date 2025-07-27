extends "res://brick.gd"

signal spawnBrickSignal(type:String, position:Vector2)

func hit():
	emit_signal("spawnBrickSignal", "base", position)
	emit_signal("score", points)
	emit_signal("popup", points, Color.RED, position)
	queue_free()
