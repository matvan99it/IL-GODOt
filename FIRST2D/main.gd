extends Node

@export var mob_scene: PackedScene

var score

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score=0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_messages("DAI SU COGGHIONE")
	


func _on_mob_timer_timeout():
	# Creo l'istanza
	var mob = mob_scene.instantiate()
	
	# Creo la generazione di nemici casuale
	var mob_spawn_location = $MobPath/MobSpawnLocation #get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Movimento mod perpendicolare
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Posizione casuale dei mob
	mob.position = mob_spawn_location.position
	
	# Randomicità alle direzioni dei mob
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Cambio di velocità dei mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn dei mob => sono aggiunti alla MainScene
	add_child(mob)
	


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


