extends CharacterBody2D

## Player slingshot movement script

enum { IDLE, DRAGGING, JUMPING, FALLING, REWINDING }

# Gravity
@export var gravity = 2000

# Slingshot power
@export var slingshot_power = 1000

# Maximum slingshot distance
@export var max_slingshot_distance = 100

# Friction
@export var friction = 1000

var state = IDLE
var drag_start_position = Vector2.ZERO
var last_safe_position = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and state == IDLE:
			state = DRAGGING
			drag_start_position = get_global_mouse_position()
			last_safe_position = position
		else:
			if state == DRAGGING:
				state = JUMPING
				var drag_end_position = get_global_mouse_position()
				var direction = (drag_start_position - drag_end_position).normalized()
				var distance = drag_start_position.distance_to(drag_end_position)
				var force = clamp(distance, 0, max_slingshot_distance) / max_slingshot_distance * slingshot_power
				velocity = direction * force

func _physics_process(delta):
	match state:
		IDLE:
			# Apply friction
			velocity.x = move_toward(velocity.x, 0, friction * delta)
			if not is_on_floor():
				state = FALLING
		DRAGGING:
			# The player should not move while dragging
			velocity = Vector2.ZERO
		JUMPING:
			# Apply gravity
			velocity.y += gravity * delta
			if velocity.y > 0:
				state = FALLING
		FALLING:
			# Apply gravity
			velocity.y += gravity * delta
			if is_on_floor():
				state = IDLE
		REWINDING:
			position = last_safe_position
			velocity = Vector2.ZERO
			state = IDLE

	if Input.is_action_just_pressed("rewind"):
		state = REWINDING

	move_and_slide()

func _draw():
	if state == DRAGGING:
		var current_mouse_position = get_global_mouse_position()
		draw_line(to_local(drag_start_position), to_local(current_mouse_position), Color.WHITE, 2)