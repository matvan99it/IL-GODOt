extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TIME = 10.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var time_scale = 2
var side_to_side = 2.5
var time: float = TIME * time_scale
	



func _physics_process(delta):
	
	# We calculate a random speed (integer)
	var random_speed = randi_range(min_speed, max_speed)
	var direction = Vector3.ZERO
	$AnimationPlayer.speed_scale = random_speed / min_speed
	# side_to_side is a uniform float
	direction.x += cos(time) * random_speed #side_to_side;
	direction.y += cos(time) * random_speed
	direction.z += cos(time) * random_speed
	
	move_and_slide()
	
	print(direction.x)

