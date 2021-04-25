extends Node

#References to Player & Enemy Scenes
export (PackedScene) var Enemy 
export (PackedScene) var Player

#References to clones of enemy & player
var enemy
var player

#Reference for playerDied bool
var playerDied = false

func _ready():
	#Starts RNG with random seed
	randomize()
	
	#Chooses a random point to put enemy
	$EnemyPath/EnemySpawnLocation.offset = randi()
	
	#Defines enemy & player to source
	var enemy = Enemy.instance()
	var player = Player.instance()
	
	#Adds enemy & player clones as children to main node
	add_child(enemy)
	add_child(player)
	
	#Sets x cord of enemy at random and y at 545
	enemy.position.x = $EnemyPath/EnemySpawnLocation.position.x
	enemy.position.y = 545
	
	#Puts player at start position
	player.position.x = 155
	player.position.y = 425
	
	#Connects the player death signal to the player_death function
	player.connect("death", self, "player_death")
	
	#Detects if player dies
func player_death() :
	playerDied = true

func _process(delta):
	if(playerDied) :
		#Restarts whole game; will replace later
		get_tree().reload_current_scene()
		playerDied = false
