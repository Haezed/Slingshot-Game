extends CharacterBody2D

## Player movement script

# Movement speed
@export var speed = 150

# Aerial drift speed
@export var air_strafe_speed = 50

# Minimum jump force
@export var min_jump_force = 500

# Maximum jump force
@export var max_jump_force = 1000

# Time it takes to reach max jump force (in seconds)
@export var charge_time = 1.0

# Gravity
@export var gravity = 2000

var jump_charge = 0.0
var is_charging = false

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump charging
	if Input.is_action_pressed("move_jump") and is_on_floor():
		is_charging = true
		jump_charge = min(jump_charge + (max_jump_force - min_jump_force) / charge_time * delta, max_jump_force)
	
	# Handle jump release
	if Input.is_action_just_released("move_jump") and is_on_floor() and is_charging:
		velocity.y = -jump_charge
		jump_charge = 0.0
		is_charging = false

	# Get input direction
	var direction = Input.get_axis("move_left", "move_right")

	# Apply movement
	if not is_charging:
		if is_on_floor():
			velocity.x = direction * speed
		else:
			velocity.x = lerp(velocity.x, direction * air_strafe_speed, 0.1)
	else:
		velocity.x = 0
	
	move_and_slide()