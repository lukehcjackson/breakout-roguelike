extends Node

@export var initialLives = 3
var lives
signal updateLivesUI(lives:int)

@export var baseBrick: PackedScene
@export var layer1Brick: PackedScene

var score
signal updateScoreText(score:int)

signal resetPlay

func _ready() -> void:
	score = 0
	handleLives(initialLives)
	
func loseLife():
	handleLives(lives-1)
	
func gainLife():
	handleLives(lives+1)
	
func handleLives(inLives):
	lives = inLives
	
	#do not let lives go negative
	if lives < 0:
		lives = 0
		
	if lives == 0:
		print("DEAD")
	
	emit_signal("updateLivesUI", lives)

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
	
func ballDeath():
	loseLife()
	resetPlay.emit()
