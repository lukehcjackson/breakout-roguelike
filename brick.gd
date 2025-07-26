extends StaticBody2D

@export var points = 1

signal score(points:float)

func hit():
	print("HIT DA BRICKS")
	emit_signal("score", points)
	queue_free()
