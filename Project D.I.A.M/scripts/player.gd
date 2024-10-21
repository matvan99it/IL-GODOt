extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -800.0
const SLIDE_SPEED: float = 800.0
const GO_DOWN: float = 1000.0
const DASH_DURATION: float = 0.5

signal hit 


var enemy_in_range: bool = false
var enemy_attack_cooldown: bool = true
var enemy_stun: bool = false

var up: bool = true
var current: String


var mob = null
var remaining_mob: Array = []

var attack_cooldown: bool = false
var is_attacking: bool = false
var is_invincible: bool = false
#Per ora non servono
@export var health: int = 100
@export var atk_speed: float = .4

var player_alive: bool = true

@onready var hit_animation = $FlashAnimation
@onready var attack_animation = $AttackBody/Attack_animation

"""
I nemici piccoli non stunnano se non dopo 3/4 attacchi consecutivi e sono SEMPRE stunnati da ogni attacco fatto dal player
I miniboss e boss non sono/non fanno stun sempre tranne con attacchi pesanti o combo
"""

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tween: Tween
var dash_velocity := 0.0

func _physics_process(delta):
	
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
		
	#ATTACCATI AL TACATA
	if Input.is_action_just_pressed("attack") and not attack_cooldown:
		print("CACATI ADDOSSO")
		is_attacking = true
		if not mob.is_connected("attacked", Callable(self, "doAttack")):
			mob.attacked.connect(doAttack)
		else:
			doAttack()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("dash"):
		dash_velocity = SLIDE_SPEED
		if tween:
			tween.stop()
			rotate(deg_to_rad(0))
		tween = create_tween()
		tween.tween_property(self, "dash_velocity", 0, .3).set_ease(Tween.EASE_OUT)
	
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


#TODO: capire perchè quando uccidi un mostro dalla lista, questa viene svuotata
func _on_player_hitbozz_body_exited(body):
	
	if remaining_mob.is_empty():
		print("finiti")
		enemy_in_range = false
		remaining_mob = []
		self.mob = null
	else:
		remaining_mob.erase(mob)
		mob = null
		print(remaining_mob.size(), " ", remaining_mob)
		enemy_in_range = true
		if remaining_mob.size() > 0:
			mob = remaining_mob[0]

func enemy_attack():
	if enemy_in_range:
		hit.emit()
		is_invincible = true
		if(health <= 0):
			print("MORTP")
			kill_player()

#TODO: capire perchè svuota l'array
func doAttack():
	if not attack_cooldown:
		if(up):
			attack_animation.play("attack_down")
			up = false
		else:
			attack_animation.play("attack_up")
			up = true
		
		$PAttackCooldown.start()
		attack_cooldown = true
		
		if enemy_in_range and mob != null:
			mob.health -= 200
			mob.flashan.play("flash_mob")
			if(mob.health <= 0):
				remaining_mob.erase(mob)
				print("b", remaining_mob.size(), " ", remaining_mob)
				if(not remaining_mob.is_empty()):
					print("Rimnagono ", remaining_mob.size(), " e sono ", remaining_mob)
					print("Non vuoto")
					mob = remaining_mob[0]
		

func kill_player():
	self.queue_free()


func _on_p_attack_cooldown_timeout():
	attack_cooldown = false
	is_attacking = false


func _on_after_damage_invincibility_timeout():
	is_invincible = false
