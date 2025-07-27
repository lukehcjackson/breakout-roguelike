extends CanvasLayer

@export var popup: PackedScene
@export var lifeIcon: PackedScene

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

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
