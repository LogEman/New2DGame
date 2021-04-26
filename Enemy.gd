extends Area2D

signal enemyDeath

var enemyHealth = 2

var cooldownComplete = true

var playerHasEntered = false

var enemyDamaged = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	enemyHealth = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (playerHasEntered && Input.is_action_pressed("ui_fight") && cooldownComplete):
		enemyHealth -= 1
		$cooldown.start()
		cooldownComplete = false
	if (enemyHealth <= 0) :
			emit_signal("enemyDeath")
			queue_free()

func playerEnter(area):
	playerHasEntered = true
		
func playerExit(area):
	playerHasEntered = false

func cooldown_complete():
	cooldownComplete = true
