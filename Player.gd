extends Area2D


var frames
var speed = 400
var health = 100
var damageStrength = 25
var damageTimer = 20
var damageTimerDelta = 0
var currentDamageTimer = 0
var playerWasHit

func playerHit(area):
	playerWasHit = true

func playerNotHit(area):
	playerWasHit = false
		
func _process(delta):
	var velocity = Vector2() #Players movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$PlayerSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$PlayerSprite.flip_h = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerSprite.play()
	else:
		$PlayerSprite.stop()
	position += velocity * delta
	if (playerWasHit == true) :
		damageTimerDelta = damageTimer * delta * 1000
		if (currentDamageTimer <= damageTimerDelta) :
			currentDamageTimer += 1
		elif (health > 0) :
			health = health - damageStrength
		elif (health <= 0):
			hide()
			
