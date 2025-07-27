extends Node

@export var baseBrick: PackedScene
@export var layer1Brick: PackedScene

var score
signal updateScoreText(score:int)

func _ready() -> void:
	score = 0

func handleScore(inScore):
	score += inScore
	emit_signal("updateScoreText",score)

func spawnBrick(type, inputPosition):
	match type:
		"base":
			actuallySpawnBrick(baseBrick, inputPosition)
		"layer1":
			actuallySpawnBrick(layer1Brick, inputPosition)
		_:
			print("unknown brick type")

func actuallySpawnBrick(toSpawn: PackedScene, targetPosition):
	var brick = toSpawn.instantiate()
	brick.position = targetPosition
	add_child(brick)
	if toSpawn != baseBrick:
		brick.connect("spawnBrickSignal", Callable(self, "spawnBrick"))
	brick.connect("score", Callable(self, "handleScore"))
	brick.connect("popup", Callable($HUD, "colour_popup"))
