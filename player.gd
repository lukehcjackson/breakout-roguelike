extends CharacterBody2D

@export var speed = 400
var screen_size
var width_of_side_bars = 121

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		#don't actually think i need to normalise but whatever
		velocity = velocity.normalized() * speed
		
	#position += velocity * delta
	#position = position.clamp(Vector2(0 + width_of_side_bars, 0), 
	#						  Vector2(screen_size.x - width_of_side_bars, screen_size.y))
	
	var collision = move_and_collide(velocity * delta)
