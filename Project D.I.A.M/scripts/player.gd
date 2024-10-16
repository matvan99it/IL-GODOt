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
var remaining_mob = []

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
		print("Rimnagono ", remaining_mob.size(), " e sono ", remaining_mob)
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
	if body.is_in_group("enemy"):
		enemy_in_range = true
		mob = body
		
		remaining_mob.append_array(
			$player_hitbozz
			.get_overlapping_bodies()
			.filter(
				func(e): 
					return e.is_in_group("enemy")  ))

		print("Rimnagono ", remaining_mob.size(), " e sono ", remaining_mob)


func _on_player_hitbozz_body_exited(body):
	
	if(remaining_mob.is_empty()):
		enemy_in_range = false
		remaining_mob = []
		self.mob = null
	else:
		remaining_mob.erase(mob)
		mob = remaining_mob[0]
	
	
	
	
func enemy_attack():
	if enemy_in_range:
		hit.emit()
		is_invincible = true
		if(health <= 0):
			print("MORTP")
			kill_player()


func doAttack():
	if enemy_in_range and not attack_cooldown and mob != null:
		$PAttackCooldown.start()
		attack_cooldown = true
		mob.health -= 200
		mob.flashan.play("flash_mob")
		if(mob.health <= 0):
			remaining_mob.erase(mob)
			print(remaining_mob)
			if(not remaining_mob.is_empty()):
				mob = remaining_mob[0]
		print("TACCIDE: ", mob.health)
		

func kill_player():
	self.queue_free()


func _on_p_attack_cooldown_timeout():
	attack_cooldown = false
	is_attacking = false


func _on_after_damage_invincibility_timeout():
	is_invincible = false
