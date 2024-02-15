extends Node

@export var mob_scene: PackedScene


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	# Connesso lo scorelabel al signal squashed per aggiornare il punteggio
	mob.squashed.connect($GUI/ScoreLabel._on_mob_squashed.bind())

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $GUI/Retry.visible:
		get_tree().reload_current_scene()

func _on_player_hit():
	$MobTimer.stop()
	$GUI/Retry.show()

func _ready():
	$GUI/Retry.hide()
