extends CharacterBody2D
class_name player_base 

const JUMP_VELOCITY: float = -800.0
const SLIDE_SPEED: float = 800.0
const SPEED: float = 300.0
const GO_DOWN: float = 1000.0
const DASH_DURATION: float = 0.5

signal hit 


var enemy_in_range: bool = false
var enemy_attack_cooldown: bool = true
var enemy_stun: bool = false
var right: bool = true
var up: bool = true
var current: String
var combo_max_count: int = 3

var mob = null
var remaining_mob: Array = []

var attack_cooldown: bool = false
var is_attacking: bool = false
var is_invincible: bool = false
#Per ora non servono
@export var HEALTH: int = 100
@export var ATK_SPEED: float = .4

var player_alive: bool = true

@onready var hit_animation = $FlashAnimation
@onready var attack_animation = $AttackBody/Attack_animation

"""
I nemici piccoli non stunnano se non dopo 3/4 attacchi consecutivi e sono SEMPRE stunnati da ogni attacco fatto dal player
I miniboss e boss non sono/non fanno stun sempre tranne con attacchi pesanti o combo
"""

#TODO: LOGISTICA PLAYER
"""
Se faccio più pg devo fare in modo di selezionarlo ogni volta ma devo sistemare il player per renderlo generico e poi creare le classi per come qui

##this
extends KinematicBody2D

# Caratteristiche comuni
var health: int = 100
var speed: float = 200.0  # Velocità di movimento di default
var attack_speed: float = 1.0  # Tempo tra un attacco e l'altro

# Funzione di movimento comune
func move(direction: Vector2, delta: float):
	var velocity = direction.normalized() * speed
	move_and_slide(velocity)

# Funzione per subire danno
func take_damage(damage: int):
	health -= damage
	if health <= 0:
		die()

# Funzione per morire (overrideabile)
func die():
	print(self.name, " è morto.")
	queue_free()

# Funzione per attaccare (ogni personaggio può personalizzarla)
func attack():
	print(self.name, " attacca con velocità di attacco: ", attack_speed)



##Player 1
extends "res://Character.gd"

# Sovrascriviamo alcune caratteristiche
func _ready():
	health = 150  # Il guerriero ha più salute
	speed = 150.0  # Il guerriero è più lento
	attack_speed = 0.8  # Il guerriero attacca lentamente

# Personalizza la funzione di attacco
func attack():
	print("Il guerriero colpisce con la spada!")
	# Logica d'attacco personalizzata qui



##Player 2
extends "res://Character.gd"

# Sovrascriviamo alcune caratteristiche
func _ready():
	health = 100  # L'arciere ha meno salute
	speed = 250.0  # L'arciere è più veloce
	attack_speed = 1.5  # L'arciere attacca rapidamente

# Personalizza la funzione di attacco
func attack():
	print("L'arciere lancia una freccia!")
	# Logica d'attacco personalizzata qui




"""



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tween: Tween
var dash_velocity := 0.0
var direction: float = 0.0

func _init(
	health: int = 100, 
	atk_speed: float = 0.6, 
	defense: float = 5
	):
	self.HEALTH = health
	self.ATK_SPEED = atk_speed
	

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration
	direction = Input.get_axis("ui_left", "ui_right")
	
	enemy_attack()
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("move_left"):
		if right:
			$Sprite2D.set_flip_h(right)
			right = not right
			$AttackBody.position.x = $AttackBody.position.x * (-1)
	
	if Input.is_action_just_pressed("move_right"):
		if not right:
			$Sprite2D.set_flip_h(right)
			right = not right
			$AttackBody.position.x = $AttackBody.position.x * (-1)
			


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if(Input.is_action_just_pressed("ui_down") and not is_on_floor()):
		velocity.y = GO_DOWN

	if(Input.is_action_just_pressed("ui_down") and Input.is_action_just_pressed("ui_accept") and is_on_floor()):
		position.y += 1
		
	#ATTACCATI AL TACATA
	#movimenti(delta)
		
	#ATTACCATI AL TACATA
	if Input.is_action_just_pressed("attack") and not attack_cooldown:
	
		is_attacking = true
		
		if mob != null:
			if not mob.is_connected("attacked", Callable(self, "doAttack")):
				mob.attacked.connect(doAttack)
			else:
				doAttack()
		else:
			doAttack()

	
	if Input.is_action_just_pressed("dash"):
		dash_velocity = SLIDE_SPEED
		if tween:
			tween.stop()
			rotate(deg_to_rad(0))
		tween = create_tween()
		tween.tween_property(self, "dash_velocity", 0, .3).set_ease(Tween.EASE_OUT)
	
	if direction:#movimento
		velocity.x = direction * (SPEED + dash_velocity)
	else:#fermo
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()


func player_hitbox(body, entered: bool):
	if entered:
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
	else:
		if body.is_in_group("enemy"):
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
		if(HEALTH <= 0):
			print("MORTP")
			kill_player()


func kill_player():
	self.queue_free()
	
	
func doAttack():
	pass


func weapon_area(body):
	if body.is_in_group("mob"):
		mob = body
		mob.attacked.connect(doAttack)


func _on_player_hitbozz_body_entered(body):
	player_hitbox(body, true)


func _on_player_hitbozz_body_exited(body):
	player_hitbox(body, false)


func _on_weapon_area_detection_body_entered(body):
	weapon_area(body)
	

func _on_p_attack_cooldown_timeout():
	attack_cooldown = false
	is_attacking = false


func _on_after_damage_invincibility_timeout():
	is_invincible = false
