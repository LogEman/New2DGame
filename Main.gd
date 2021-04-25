extends Node

export (PackedScene) var Enemy
export (PackedScene) var Player

var enemy
var player

var playerDied = false

func _ready():
	randomize()
	
	$EnemyPath/EnemySpawnLocation.offset = randi()
	
	var enemy = Enemy.instance()
	var player = Player.instance()
	
	add_child(enemy)
	add_child(player)
	
	enemy.position.x = $EnemyPath/EnemySpawnLocation.position.x
	enemy.position.y = 545
	
	player.position.x = 155
	player.position.y = 425
	
	player.connect("death", self, "player_death")
	
func player_death() :
	playerDied = true

func _process(delta):
	if(playerDied) :
		get_tree().reload_current_scene()
		playerDied = false
