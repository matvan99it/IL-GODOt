extends Node

"""
Il player una volta che sconfigge il 90% dei nemici cioè almeno il 50% dei minion e il miniboss conquista la zona 
che diventa una nuova zona da conquistare per i nemici o fa spawnare un BOSS


"""

@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$sliderAnimation.play("slide")
	new_game()

func new_game():
	get_tree().call_group("mobs", "queue_free")

func _on_enemy_spawn_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $EnemySpawn
	mob.position = mob_spawn_location.position
	add_child(mob)
