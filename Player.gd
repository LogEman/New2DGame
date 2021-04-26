extends Area2D
#References to variables
var health = 10
var speed = 400
var damageStrength = 1.5
var damageTimer = 2
var damageTimerDelta = 0
var currentDamageTimer = 0
var playerWasHit
var maxJump = 200
var floorPosition = 423

#Reference to death signal
signal death
signal playerHealth(currentHealth)


#Bool references
var isJumping = false
var jumpDisabled = false

#Detects if player is damaged/hit
# warning-ignore:unused_argument
func playerHit(area):
	playerWasHit = true

#Detects when player is no longer being damaged/hit
# warning-ignore:unused_argument
func playerNotHit(area):
	playerWasHit = false
	
func boostHealth() :
	health += 1
	
func _ready():
	var healthBoost = get_tree().get_root().find_node("Main", true, false)
	healthBoost.connect("healthBoost", self, "boostHealth")
	
func _process(delta):
	
	emit_signal("playerHealth", health)
	var velocity = Vector2() #Players movement vector
	#Detects key presses and changes velocity based on them
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$PlayerSprite.flip_h = false #Makes player sprite unflipped
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$PlayerSprite.flip_h = true #Flips player sprite
		
	#Activates gravity if not jumping and above floor
	if (position.y < floorPosition && !isJumping) :
		velocity.y += 1
	
	#Detects jump button press and makes sure player can't fly
	if (Input.is_action_pressed("ui_up") && position.y > maxJump && !jumpDisabled):
		velocity.y -= 1
		isJumping = true
		
	#Temporarily disables jumping if player lets go of jump button mid-jump; prevents gravity cancelling
	if (isJumping && !Input.is_action_pressed("ui_up") || position.y < maxJump) :
		jumpDisabled = true
		isJumping = false
	#Detects when player is on the floor and allows them to jump again
	if (position.y > floorPosition + 1) :
		jumpDisabled = false
	#Corrects weird issues with velocity and plays walking animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PlayerSprite.play()
	else:
		#Stops player sprite when not moving and resets the animation cycle
		$PlayerSprite.stop()
		$PlayerSprite.set_frame(0)
	#Translates player velocity to position
	position += velocity * delta
	#Player damage system
	if (playerWasHit == true) :
		#Sets a timer adjusted for frame rate
		damageTimerDelta = damageTimer / delta
		#Counts up damage timer if not completed
		if(playerWasHit && Input.is_action_pressed("ui_fight")):
			currentDamageTimer = 0
			
		if (currentDamageTimer <= damageTimerDelta) :
			currentDamageTimer += 1
		#Gives player damage if not dead
		if (health > 0.0 && currentDamageTimer >= damageTimerDelta) :
			health -= damageStrength
			currentDamageTimer = 0
		#Resets player when they die
		if (health <= 0.0):
			hide()
			position.x = 155
			position.y = 400
			health = 10
			emit_signal("death")
			show()
