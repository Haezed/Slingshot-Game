extends CharacterBody2D

## Player movement script

# Movement speed
@export var speed = 300

# Jump height
@export var jump_force = 700

# Gravity
@export var gravity = 2000

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_force

	# Get input direction
	var direction = Input.get_axis("ui_left", "ui_right")

	# Apply movement
	velocity.x = direction * speed
	
	move_and_slide()