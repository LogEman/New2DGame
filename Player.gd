extends Area2D
var health = 100
var speed = 400
var damageStrength = 25.0
var damageTimer = 20
var damageTimerDelta = 0
var currentDamageTimer = 0
var playerWasHit
var maxJump = 200
var floorPosition = 424

var isJumping = false
var jumpDisabled = false

func playerHit(area):
	playerWasHit = true

func playerNotHit(area):
	playerWasHit = false
		
func _process(delta):
	var velocity = Vector2() #Players movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$PlayerSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$PlayerSprite.flip_h = true
		
	if (position.y < floorPosition && !isJumping) :
		velocity.y += 1
		
	if (Input.is_action_pressed("ui_up") && position.y > maxJump && !jumpDisabled):
		velocity.y -= 1
		isJumping = true
	if (isJumping && !Input.is_action_pressed("ui_up") || position.y < maxJump) :
		jumpDisabled = true
		isJumping = false
	if (position.y > floorPosition + 1) :
		jumpDisabled = false
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerSprite.play()
	else:
		$PlayerSprite.stop()
		
	position += velocity * delta
	
	if (playerWasHit == true) :
		damageTimerDelta = damageTimer / delta
		if (currentDamageTimer <= damageTimerDelta) :
			currentDamageTimer += 1
		elif (health > 0.0) :
			health = health - damageStrength
		elif (health <= 0.0):
			hide()
