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


const SPEED = 35.0
var chasing: bool = false
var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
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


