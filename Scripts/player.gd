extends CharacterBody2D

## Player slingshot movement script

# Gravity
@export var gravity = 2000

# Slingshot power
@export var slingshot_power = 1000

# Maximum slingshot distance
@export var max_slingshot_distance = 100

# Friction
@export var friction = 1000

var is_dragging = false
var drag_start_position = Vector2.ZERO
var drag_end_position = Vector2.ZERO
var last_safe_position = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and is_on_floor():
			is_dragging = true
			drag_start_position = get_global_mouse_position()
		else:
			if is_dragging:
				is_dragging = false
				drag_end_position = get_global_mouse_position()
				var direction = (drag_start_position - drag_end_position).normalized()
				var distance = drag_start_position.distance_to(drag_end_position)
				var force = clamp(distance, 0, max_slingshot_distance) / max_slingshot_distance * slingshot_power
				velocity = direction * force

	if Input.is_action_just_pressed("rewind"):
		position = last_safe_position

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Store the last safe position when on the floor and not moving
		if velocity.x == 0:
			last_safe_position = position

	# Apply friction
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()

func _draw():
	if is_dragging:
		var current_mouse_position = get_global_mouse_position()
		draw_line(to_local(drag_start_position), to_local(current_mouse_position), Color.WHITE, 2)