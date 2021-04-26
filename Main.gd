extends Node

#References to Player & Enemy Scenes
export (PackedScene) var Enemy 
export (PackedScene) var Player

#References to clones of enemy & player
var enemy
var player

var playerHealth

signal healthBoost

#Reference for playerDied bool
var playerDied = false
var enemyDied = false

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
	player.connect("playerHealth", self, "player_health")
	
	enemy.connect("enemyDeath", self, "enemy_death")
	#Detects if player dies
func player_death() :
	playerDied = true

func player_health(health) :
	playerHealth = health

func enemy_death() :
	enemyDied = true

func _process(delta):
	if (enemyDied):
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy = Enemy.instance()
		add_child(enemy)
		enemy.position.x = $EnemyPath/EnemySpawnLocation.position.x
		enemy.position.y = 545
		enemy.connect("enemyDeath", self, "enemy_death")
		enemyDied = false
		emit_signal("healthBoost")
	
	if(playerDied) :
		#Restarts whole game; will replace later
		get_tree().reload_current_scene()
		playerDied = false
	if(playerHealth == 10):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(0)
		$PlayerHealth/PlayerHeart4.set_frame(0)
		$PlayerHealth/PlayerHeart5.set_frame(0)
	if(playerHealth == 9):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(0)
		$PlayerHealth/PlayerHeart4.set_frame(0)
		$PlayerHealth/PlayerHeart5.set_frame(2)
	if(playerHealth == 8):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(0)
		$PlayerHealth/PlayerHeart4.set_frame(0)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 7):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(0)
		$PlayerHealth/PlayerHeart4.set_frame(2)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 6):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(0)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 5):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(2)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 4):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(0)
		$PlayerHealth/PlayerHeart3.set_frame(1)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 3):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(2)
		$PlayerHealth/PlayerHeart3.set_frame(1)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 2):
		$PlayerHealth/PlayerHeart1.set_frame(0)
		$PlayerHealth/PlayerHeart2.set_frame(1)
		$PlayerHealth/PlayerHeart3.set_frame(1)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 1):
		$PlayerHealth/PlayerHeart1.set_frame(2)
		$PlayerHealth/PlayerHeart2.set_frame(1)
		$PlayerHealth/PlayerHeart3.set_frame(1)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
	if(playerHealth == 0):
		$PlayerHealth/PlayerHeart1.set_frame(1)
		$PlayerHealth/PlayerHeart2.set_frame(1)
		$PlayerHealth/PlayerHeart3.set_frame(1)
		$PlayerHealth/PlayerHeart4.set_frame(1)
		$PlayerHealth/PlayerHeart5.set_frame(1)
