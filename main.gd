extends Node

@export var initialLives = 3
var lives
signal updateLivesUI(lives:int)

signal gameOver(score:int)

@export var tier0: PackedScene
@export var tier1: PackedScene
@export var tier2: PackedScene
@export var tier3: PackedScene
@export var tier4: PackedScene
@export var tier5: PackedScene
@export var tier6: PackedScene

var score
signal updateScoreText(score:int, mult:int)
var mult

signal resetPlay

signal generateDefaultDeck
signal generateLevel

func _ready() -> void:
	score = 0
	mult = 1
	handleLives(initialLives)
	generateDefaultDeck.emit()
	generateLevel.emit()
	
func loseLife():
	handleLives(lives-1)
	processScore()
	
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

func increaseMult():
	mult += 1

func handleScore(inScore):
	score += inScore
	emit_signal("updateScoreText", score, mult)
	
func processScore():
	score = score * mult
	mult = 1
	emit_signal("updateScoreText", score, mult)
	
func game_over():
	$"The Ball".hide()
	$"The Ball".process_mode = Node.PROCESS_MODE_DISABLED
	$Player.hide()
	$Player.process_mode = Node.PROCESS_MODE_DISABLED
	#todo hide all remaining bricks? or drop shadow on game over text?
	processScore()
	emit_signal("gameOver", score)

func spawnBrick(type, inputPosition):
	match type:
		"tier0":
			actuallySpawnBrick(tier0, inputPosition)
		"tier1":
			actuallySpawnBrick(tier1, inputPosition)
		"tier2":
			actuallySpawnBrick(tier2, inputPosition)
		"tier3":
			actuallySpawnBrick(tier3, inputPosition)
		"tier4":
			actuallySpawnBrick(tier4, inputPosition)
		"tier5":
			actuallySpawnBrick(tier5, inputPosition)
		"tier6":
			actuallySpawnBrick(tier6, inputPosition)
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
	
	if toSpawn == tier6:
		#gold brick adds +1 to mult
		brick.connect("increaseMult", Callable(self, "increaseMult"))
	
func ballDeath():
	loseLife()
	resetPlay.emit()
