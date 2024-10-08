extends Node

"""
Il player una volta che sconfigge il 90% dei nemici cioè almeno il 50% dei minion e il miniboss conquista la zona 
che diventa una nuova zona da conquistare per i nemici o fa spawnare un BOSS


"""

@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	spawnMassivo($Stanza2, 20)
	
	$sliderAnimation.play("slide")
	new_game()

func new_game():
	get_tree().call_group("mobs", "queue_free")

func _on_enemy_spawn_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $EnemySpawn
	mob.position = mob_spawn_location.position
	add_child(mob)

func randoPoint(selectedArea: Area2D) -> Vector2:
	var local_point = selectedArea.position
	
	for child in selectedArea.get_children():
		if(child is CollisionShape2D):
			var cr = child.shape
			var rect = child.shape.get_rect()
			print("BANANA")
			print(rect)
			var x = randf_range(rect.position.x, rect.position.x+rect.size.x)
			var y = randf_range(rect.position.y, rect.position.y+rect.size.y)
			local_point = Vector2(x,y)
			break
		elif(child is CollisionPolygon2D):
			var cp = child.polygon
			var random_vertex_index = randi() % cp.size()
			local_point = cp[random_vertex_index]
			break

	return selectedArea.global_position + local_point
	
	
func spawnMassivo(selectedArea: Area2D, mobnum: int):
	for i in range(mobnum):
		var mob = mob_scene.instantiate()
		var mob_spawn_location = $EnemySpawn
		mob.position = randoPoint(selectedArea)
		selectedArea.add_child(mob)
		

