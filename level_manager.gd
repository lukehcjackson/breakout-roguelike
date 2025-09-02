extends Node

#does the level have a fixed score requirement curve (i.e. balatro)
#or is the required score calculated based on the board (i.e nubby)

#if the first, this will be quite easy to implement
#otherwise, this script needs a copy of what is on the board and then to calculate things like
#max potential score given best order of hitting mult tiles, other special tiles i add later on ...

var currentLevel
var currentScoreRequirement

signal resetLives
signal generateNewLevel
signal clearLevel
signal updateRequirementText(req: int)

func _ready() -> void:
	currentLevel = 1
	currentScoreRequirement = calculateScoreRequirement(currentLevel)
	emit_signal("updateRequirementText", currentScoreRequirement)
	print("current score req: " + str(currentScoreRequirement))
	
	for i in range(1, 10):
		print("i: " + str(i) + " score: " + str(calculateScoreRequirement(i)))
	
func calculateScoreRequirement(level) -> int:
	#formula to calculate score requirement from level goes here
	#return 100 * floor((level * log(level))) + 200 * level
	return 100 * floor(level ** 1.9) + 200 * level
	
func checkIfLevelPassed(score):
	if score >= currentScoreRequirement:
		levelPassed()
	
func levelPassed():
	#if the level is passed:
	#	reset the lives counter (to 3, or to the max it has been so far?)
	#	go to choose from 3 things menu
	#	redraw the board from the (new) deck
	#	calculate new level score requirement and display this on the screen
	#	resume play
	
	resetLives.emit()

	clearLevel.emit()
	
	#todo edit deck in some way
	
	generateNewLevel.emit()
	
	currentLevel += 1
	currentScoreRequirement = calculateScoreRequirement(currentLevel)
	emit_signal("updateRequirementText", currentScoreRequirement)
	
	print("level: " + str(currentLevel))
	print("score req: " + str(currentScoreRequirement))
