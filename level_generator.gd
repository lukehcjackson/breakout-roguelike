extends Node

#generate the level from the deck
#shuffle the deck, choose some number of tiles from the deck, place them in the level
#need spots where we are going to spawn the tiles

func generate_level(deck):
	var tileSpawnPositions = []
	var children = self.get_child_count()
	for i in range(children):
		tileSpawnPositions.append(self.get_child(i))
	
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


func clear_level():
	var bricks = get_tree().get_nodes_in_group("brick")
	for brick in bricks:
		if is_instance_valid(brick):
			brick.queue_free()
