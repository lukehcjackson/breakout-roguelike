extends "res://brick.gd"

signal spawnBrickSignal(type:String, position:Vector2)

func hit():
	print("hit da red brick")
	emit_signal("spawnBrickSignal", "base", position)
	emit_signal("score", points)
	queue_free()
