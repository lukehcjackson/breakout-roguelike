extends Node

enum TILES {TIER0, TIER1, TIER2, TIER3, TIER4, TIER5, TIER6, TIER7}

var deck = []
signal passDeck(deck:Array)

func generateDefaultDeck():
	var defaultDeck = []
	for i in range(300):
		defaultDeck.append(TILES.TIER0)
	for i in range(30):
		defaultDeck.append(TILES.TIER1)
	for i in range(30):
		defaultDeck.append(TILES.TIER2)
		
		
	defaultDeck.shuffle()
	deck = defaultDeck
	
func passDeckToGenerator():
	emit_signal("passDeck", deck)
