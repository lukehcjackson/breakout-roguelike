extends Node

@export var initialLives = 3
var lives
signal updateLivesUI(lives:int)

signal gameOver(score:int)

@export var tier0: PackedScene
@export var tier1: PackedScene
@export var tier2: PackedScene

var score
signal updateScoreText(score:int)

signal resetPlay

signal generateDefaultDeck
signal generateLevel

func _ready() -> void:
	score = 0
	handleLives(initialLives)
	generateDefaultDeck.emit()
	generateLevel.emit()
	
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
		game_over()
	
	emit_signal("updateLivesUI", lives)

func handleScore(inScore):
	score += inScore
	emit_signal("updateScoreText",score)
	
func game_over():
	$"The Ball".hide()
	$"The Ball".process_mode = Node.PROCESS_MODE_DISABLED
	$Player.hide()
	$Player.process_mode = Node.PROCESS_MODE_DISABLED
	#todo hide all remaining bricks?
	emit_signal("gameOver", score)

func spawnBrick(type, inputPosition):
	match type:
		"tier0":
			actuallySpawnBrick(tier0, inputPosition)
		"tier1":
			actuallySpawnBrick(tier1, inputPosition)
		"tier2":
			actuallySpawnBrick(tier2, inputPosition)
		_:
			print("unknown brick type")

func actuallySpawnBrick(toSpawn: PackedScene, targetPosition):
	var brick = toSpawn.instantiate()
	brick.position = targetPosition
	add_child(brick)
	if toSpawn != tier0:
		brick.connect("spawnBrickSignal", Callable(self, "spawnBrick"))
	brick.connect("score", Callable(self, "handleScore"))
	brick.connect("popup", Callable($HUD, "colour_popup"))
	
func ballDeath():
	loseLife()
	resetPlay.emit()
