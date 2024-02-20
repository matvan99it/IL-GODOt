extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TIME = 5.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var VERTEX = Vector3.ZERO
var time_scale = 0.5
var side_to_side = 2.5
var time: float = TIME * time_scale

func _physics_process(delta):
	
	var direction = Vector3.ZERO
	
	# side_to_side is a uniform float
	direction.x += cos(time) * side_to_side;

	move_and_slide()
