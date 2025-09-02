extends Node

#generate the level from the deck
#shuffle the deck, choose some number of tiles from the deck, place them in the level
#need spots where we are going to spawn the tiles

func generate_level(deck):
	#get a list of referenes to all marker2d's - that is all children of this node that don't have a child / all children of children of this node of type marker2d
	var tileSpawnPositions = []
	#var rows = self.get_child_count()
	#for i in range(rows):
		#var cols = self.get_child(i).get_child_count()
		#for j in range(cols):
			#tileSpawnPositions.append(self.get_child(i).get_child(j))
	
	var children = self.get_child_count()
	for i in range(children):
		tileSpawnPositions.append(self.get_child(i))
	
	#print(tileSpawnPositions)
	
	deck.shuffle()
	
	#for each position we want to spawn a tile
	for spawnPosition in range(len(tileSpawnPositions)):
		#if there is enough tiles in the deck to spawn a tile in this position
		if len(deck) > spawnPosition:
			#spawn a tile in this position
			#print(deck[spawnPosition])
			var toSpawn = "tier" + str(deck[spawnPosition])
			#call main.spawnBrick
			$"..".spawnBrick(toSpawn, tileSpawnPositions[spawnPosition].position)
		
