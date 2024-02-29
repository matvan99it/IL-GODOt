extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var pivot = $CameraPivot
@onready var camera = $CameraPivot/PlayerCamera

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sensitivity: float= 0.001
var twist_input: float = 0.0
var pitch_input: float = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Leftward", "Rightward", "Forward", "Backward")
	var direction = (pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	#apply_central_force(Vector3.ZERO * 1200.0 * delta)
	
	direction = pivot.basis * velocity * 1200.0 * delta
	pivot.rotate_y(twist_input)
	camera.rotate_x(pitch_input)
	
	camera.rotation.x = clamp(
		camera.rotation.x, 
		deg_to_rad(-30), 
		deg_to_rad(30)
	)
	twist_input = .0
	pitch_input = .0
	
	
	
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if(Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
