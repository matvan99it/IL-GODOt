extends CharacterBody2D

const SPEED = 200.0
var chasing: bool = false
var player = null

func _physics_process(delta):
	if chasing and player:
		var direction = (player.position - position).normalized()
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO  # Il nemico si ferma se non insegue il giocatore

	# Muove il nemico e gestisce le collisioni
	move_and_slide()

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"): # Assicurati che il rilevamento funzioni solo per il player
		player = body
		chasing = true
		rotate(deg_to_rad(90))

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		chasing = false
		rotate(deg_to_rad(-90))
