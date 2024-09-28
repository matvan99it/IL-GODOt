extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0
const SLIDE_SPEED = 800.0
const GO_DOWN = 1000.0
const DASH_DURATION = 0.5

signal hit 
var enemy_in_range = false
var enemy_attack_cooldown = true
var enemy_stun = false

#Per ora non servono
@export var health = 100
var player_alive = true

"""
I nemici piccoli non stunnano se non dopo 3/4 attacchi consecutivi e sono SEMPRE stunnati da ogni attacco fatto dal player
I miniboss e boss non sono/non fanno stun sempre tranne con attacchi pesanti o combo
"""

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tween: Tween
var dash_velocity := 0.0

func _physics_process(delta):
	# Add the gravity.
	
	enemy_attack()
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if(Input.is_action_just_pressed("ui_down") and not is_on_floor()):
		velocity.y = GO_DOWN

	if(Input.is_action_just_pressed("ui_down") and Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		position.y += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("dash"):
		dash_velocity = SLIDE_SPEED
		rotate(deg_to_rad(90))
		if tween:
			tween.stop()
			rotate(deg_to_rad(0))
		tween = create_tween()
		tween.tween_property(self, "dash_velocity", 0, 0.3).set_ease(Tween.EASE_OUT)
	
	if direction:
		velocity.x = direction * (SPEED + dash_velocity)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()


func _on_player_hitbozz_body_entered(body):
	if(body.is_in_group("enemy")):
		enemy_in_range = true


func _on_player_hitbozz_body_exited(body):
	if(body.is_in_group("enemy")):
		enemy_in_range = false
	
	
	
func enemy_attack():
	if(enemy_in_range):
		#health -= 1
		hit.emit()
		print("Vita rimanente: ", health)
	
	
func reduce_health(eltz: int) -> int:
	hit.emit()
	if(health <= 0):
		kill_player()
	return eltz
	

func kill_player():
	queue_free()