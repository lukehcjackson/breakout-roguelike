extends CharacterBody2D

@export var initial_speed = 200

##The proportion of initial_speed added to speed every bounce
@export var bounce_speedup = 0.1

@export var bounce_randomness = 0.5

var speed

func _ready():
	speed = initial_speed
	#velocity = Vector2.ZERO
	velocity = Vector2(0, 1) * speed
	
func _process(delta: float) -> void:
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		#print(collision.get_collider().name)
		#print(collision.get_collider().collision_layer)
		
		
		var normal = collision.get_normal()
		#todo fix this - for higher speeds, have to increase bounce randomness to compensate
		#but applying the random v2 to the normalised .bounce makes it completely unpredictable so don't do that
		velocity = (velocity.bounce(normal) + 
				   Vector2(randf_range(-bounce_randomness, bounce_randomness), 
						   randf_range(-bounce_randomness, bounce_randomness))).normalized() * speed

		if collision.get_collider().is_in_group("brick"):
			collision.get_collider().call("hit")
			speed += initial_speed * bounce_speedup
