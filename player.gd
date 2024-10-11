extends CharacterBody2D


#var speed : float = 100
#var direction : Vector2 = Vector2.ZERO
#var	has_key : bool = false
#var soundKey : AudioStreamPlayer2D
##fonction appelés une fois au début
#
#func GetKey():
	#has_key = true
	#soundKey.play()
#func _ready():
	#soundKey = $SoundKey
	#pass
	#
#@onready var animatedSprite = $Sprite2D
##fonction appelés chaque frame (update)
#func _process(delta : float): 
	#direction.x = Input.get_action_strength("Right")-Input.get_action_strength("Left")
	#direction.y = Input.get_action_strength("Down")-Input.get_action_strength("Up")
	#velocity = direction * speed
	#if(direction.x > 0):
		#animatedSprite.play("walk_right")
	#elif  (direction.x < 0):
		#animatedSprite.play("walk_left")
	#elif  (direction.y < 0):
		#animatedSprite.play("walk_up")
	#elif  (direction.y > 0):
		#animatedSprite.play("walk_down")
	#else: 
		#animatedSprite.play("default")
			#
		#
	##print(velocity)
	#pass
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
