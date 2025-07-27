extends StaticBody2D

@export var points = 1

signal score(points:float)
signal popup(points:float, colour:Color, pos:Vector2)

func hit():
	emit_signal("score", points)
	emit_signal("popup", points, Color.WHITE, position)
	queue_free()
