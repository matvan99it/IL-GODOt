extends Node


@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$sliderAnimation.play("slide")
	new_game()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	$EnemySpawnTimer.start()
	if ($EnemySpawnTimer.time_left > 0):
		print ("Timer is active")
		$CanvasLayer/LabelTimer.text += "pippo"
	else:
		$CanvasLayer/LabelTimer.text += "\n ODIO"

func _on_enemy_spawn_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $EnemySpawn
	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	

	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
