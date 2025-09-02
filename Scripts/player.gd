extends CharacterBody2D

## Player movement script

# Movement speed
@export var speed = 300

# Initial jump force
@export var jump_force = 500

# Maximum jump height
@export var max_jump_height = 1000

# Time it takes to reach max jump height
@export var max_jump_time = 0.4

# Gravity
@export var gravity = 2000

var jump_time = 0
var is_jumping = false

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_jumping = true
		jump_time = 0
		velocity.y = -jump_force

	if Input.is_action_pressed("ui_accept") and is_jumping:
		if jump_time < max_jump_time:
			velocity.y -= (max_jump_height / max_jump_time) * delta
			jump_time += delta
	else:
		is_jumping = false

	# Get input direction
	var direction = Input.get_axis("ui_left", "ui_right")

	# Apply movement
	velocity.x = direction * speed
	
	move_and_slide()