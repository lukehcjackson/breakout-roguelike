extends CharacterBody2D

@export var speed = 400
var screen_size
var width_of_side_bars = 121

var ballLaunched
signal launchTheBall
signal playerPosition(currentPos: Vector2)
signal ballRotation(dir:int)

func _ready():
	screen_size = get_viewport_rect().size
	ballLaunched = false
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		#don't actually think i need to normalise but whatever
		velocity = velocity.normalized() * speed
	
	var collision = move_and_collide(velocity * delta)
	
	if !ballLaunched:
		#either shoot the ball or move it relative to the paddle position
		if Input.is_action_pressed("shoot"):
			ballLaunched = true
			launchTheBall.emit()
		else:
			emit_signal("playerPosition", position)
			
		#if the ball has not been shot, we can rotate the direction it will fire
		var ballRotationDirection = 0
		if Input.is_action_pressed("turn_left"):
			ballRotationDirection -= 1
		if Input.is_action_pressed("turn_right"):
			ballRotationDirection += 1
		if ballRotationDirection != 0:
			emit_signal("ballRotation", ballRotationDirection)
