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

signal ballDeath

func _ready():
	reset()

func reset():
	speed = initial_speed
	velocity = Vector2.ZERO
	launched = false
	$RotationAnchor.rotation = 0
	await get_tree().create_timer(0.2).timeout
	$RotationAnchor.show()
	
func launch():
	launched = true
	$RotationAnchor.hide()
	#seem to have changed nothing but this stopped working and had to add the -PI/2
	velocity = Vector2.from_angle($RotationAnchor.rotation - PI/2) * speed
	
func followPaddle(pos):
	position = pos + offset
	
func rotateTheBall(dir):
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
				
			#DEATH ZONE HIT - went offscreen (or hit an object marked death zone??)
			if collision.get_collider().is_in_group("death"):
				ballDeath.emit()
				#readyToLaunch()
