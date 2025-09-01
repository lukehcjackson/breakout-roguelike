extends Node

enum TILES {TIER0, TIER1, TIER2, TIER3, TIER4, TIER5, TIER6}

var deck = []
signal passDeck(deck:Array)

func generateDefaultDeck():
	var defaultDeck = []
	#current spaces = 88
	for i in range(30):
		defaultDeck.append(TILES.TIER0)
	for i in range(30):
		defaultDeck.append(TILES.TIER1)
	for i in range(20):
		defaultDeck.append(TILES.TIER2)
	for i in range(5):
		defaultDeck.append(TILES.TIER3)
	for i in range(4):
		defaultDeck.append(TILES.TIER4)
	for i in range(3):
		defaultDeck.append(TILES.TIER5)
	for i in range(300):
		defaultDeck.append(TILES.TIER6)
		
	defaultDeck.shuffle()
	deck = defaultDeck
	
func passDeckToGenerator():
	emit_signal("passDeck", deck)
