extends CanvasLayer

@export var popup: PackedScene
@export var lifeIcon: PackedScene

func update_score(score, mult):
	$ScoreLabel.text = "Score: " + str(score)
	if mult != 1:
		$ScoreLabel.text += " x " + str(mult)
		
func update_requirement(req):
	$RequirementLabel.text = "Requirement: " + str(req)

func colour_popup(score, colour, pos):
	#instantiate a score popup displaying a certain score in a certain colour at position pos
	var scorePopup = popup.instantiate()
	add_child(scorePopup)
	scorePopup.position = pos
	scorePopup.text = "+" + str(score)
	scorePopup.add_theme_color_override("font_color", colour)
	
func update_lives_container(lives):
	var livesContainer = $LivesContainer
	#want: number of children of $LivesContainer to be equal to lives
	#if there is too few children, add them:
	while livesContainer.get_child_count() < lives:
		var life_icon = lifeIcon.instantiate()
		livesContainer.add_child(life_icon)
	#if there are too many lives, remove them:
	var to_remove = []
	for i in range (livesContainer.get_child_count() - lives):
		var child = livesContainer.get_child(livesContainer.get_child_count() - 1 - i)
		to_remove.append(child)
	for node in to_remove:
		node.queue_free()
		
func game_over(score):
	$ScoreLabel.hide()
	$RequirementLabel.hide()
	$LivesContainer.hide()
	$GameOverLabel.text = "[wave amp=70.0 freq=4.0 connected=1]Game Over!\nScore: " + str(score) + "[/wave]"
	#todo would prefer to have the text bouncing around the screen
	$GameOverLabel.show()
