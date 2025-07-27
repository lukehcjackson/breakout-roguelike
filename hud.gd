extends CanvasLayer

@export var popup: PackedScene

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func colour_popup(score, colour, pos):
	#instantiate a score popup displaying a certain score in a certain colour at position pos
	var scorePopup = popup.instantiate()
	add_child(scorePopup)
	scorePopup.position = pos
	scorePopup.text = "+" + str(score)
	scorePopup.add_theme_color_override("font_color", colour)
	
