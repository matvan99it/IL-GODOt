extends CharacterBody2D

"""
Come per OPPW

I nemici "camper" devono aspettare che il player entry o che le unità alleate entrino per cominciare ad attaccare
I nemici "nomadi" devono trovare la strada verso o il player o la zona da conquistare più vicina

I nemici si suddividono in MINION, MINIBOSS, BOSS

MINION: spawnano in un gruppo di N(TODO: capire che numero) assieme ad un miniboss
MINIBOSS: ne esiste sempre 1(uno) per area da conquistare più altri ZDC/2 per eccesso che fanno anche loro da "nomadi"
BOSS: spawna ogni tot tempo o ogni tot zone conquistate a meno di regole speciali dove c'è subito(nessun limite) -> diversi pg per mantenere il chaos

"""

signal attacked
signal killed

@onready var flashan = $AnimationPlayer

const SPEED = 35.0
var chasing: bool = false
var in_range: bool = false
var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var attack_cooldown = false
var stun = false
var health = 10
enum Status{
	Pipop,
	bbbbbb
}

func _physics_process(delta):
	# Add the gravity.
	playerAttack()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if chasing and player:
		position += (player.position - position) / SPEED
		velocity.y += gravity * delta

	move_and_slide()

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"): # Assicurati che il rilevamento funzioni solo per il player
		player = body
		chasing = true

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		chasing = false
		

#TODO: problemi con il pathfollowing
func _on_enemy_hitbox_body_entered(body):
	if body.is_in_group("player"):
		player.hit.connect(doDamage)
		in_range = true


func _on_enemy_hitbox_body_exited(body):
	if body.is_in_group("player"):
		in_range = false


func doDamage():
	if not attack_cooldown:
		attack_cooldown = true
		player.health -= 1
		player.hit_animation.play("flash")
		$EAttackCooldown.start()
		print("burba kurva ", player.health)

func playerAttack():
	if(in_range and player.is_attacking):
		attacked.emit()
		if(health <= 0):
			print("EH EH EH AHW")
			kill_mob()

func getDamage():
	pass
	
func kill_mob():
	self.queue_free()

func _on_e_attack_cooldown_timeout():
	attack_cooldown = false
