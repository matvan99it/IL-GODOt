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
var mob = null
var attack_cooldown = false
var is_attacking = false
var is_invincible = false
#Per ora non servono
@export var health = 100
var player_alive = true

@onready var hit_animation = $FlashAnimation


"""
I nemici piccoli non stunnano se non dopo 3/4 attacchi consecutivi e sono SEMPRE stunnati da ogni attacco fatto dal player
I miniboss e boss non sono/non fanno stun sempre tranne con attacchi pesanti o combo
"""

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tween: Tween
var dash_velocity := 0.0

func _physics_process(delta):
	
	#$PAttackCooldown.wait_time = 2
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
		
	
	if Input.is_action_just_pressed("attack") and enemy_in_range:
		is_attacking = true
		mob.attacked.connect(doAttack)

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
		mob = body


func _on_player_hitbozz_body_exited(body):
	if(body.is_in_group("enemy")):
		enemy_in_range = false
		mob = null
	
	
	
func enemy_attack():
	if(enemy_in_range):
		#health -= 1
		hit.emit()
		is_invincible = true
		if(health <= 0):
			print("MORTP")
			kill_player()


func doAttack():
	if enemy_in_range and not attack_cooldown:
		$PAttackCooldown.start()
		attack_cooldown = true
		mob.health -= 2
		mob.flashan.play("flash_mob") #TODO: capire perchè non va
		print("TACCIDE: ", mob.health)
		

func kill_player():
	self.queue_free()


func _on_p_attack_cooldown_timeout():
	attack_cooldown = false
	is_attacking = false


func _on_after_damage_invincibility_timeout():
	is_invincible = false
