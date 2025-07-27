extends CharacterBody2D

@export var initial_speed = 200
var speed

##The proportion of initial_speed added to speed every bounce
@export var bounce_speedup = 0.1
@export var bounce_randomness = 0.5

var launched
var offset = Vector2(0, -30)
var rotationSensitivity = 0.05
var rotationClamp = deg_to_rad(45)


func _ready():
	readyToLaunch()

func readyToLaunch():
	speed = initial_speed
	velocity = Vector2.ZERO
	launched = false
	
func launch():
	launched = true
	$RotationAnchor.hide()
	velocity = Vector2.from_angle($RotationAnchor.rotation) * speed
	
func followPaddle(pos):
	print(pos)
	position = pos + offset
	
func rotateTheBall(dir):
	print(dir)
	$RotationAnchor.rotation += dir * rotationSensitivity
	$RotationAnchor.rotation = clamp($RotationAnchor.rotation, -rotationClamp, rotationClamp)

func _process(delta: float) -> void:
	if launched:
		var collision = move_and_collide(velocity * delta)
		if collision:
			#BOUNCE
			var normal = collision.get_normal()
			#todo fix this - for higher speeds, have to increase bounce randomness to compensate
			#but applying the random v2 to the normalised .bounce makes it completely unpredictable so don't do that
			velocity = (velocity.bounce(normal) + 
					   Vector2(randf_range(-bounce_randomness, bounce_randomness), 
							   randf_range(-bounce_randomness, bounce_randomness))).normalized() * speed
			#BRICK HIT
			if collision.get_collider().is_in_group("brick"):
				collision.get_collider().call("hit")
				speed += initial_speed * bounce_speedup
