extends Node2D

"""
Il player una volta che sconfigge il 90% dei nemici cioè almeno il 50% dei minion e il miniboss conquista la zona 
che diventa una nuova zona da conquistare per i nemici o fa spawnare un BOSS


"""

@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn_mobs(100, $Stanza2)
	spawn_mobs(20, $Stanza3)
	#spawn_mobs(100, $Stanza4)
	
	$sliderAnimation.play("slide")
	new_game()

func new_game():
	get_tree().call_group("mobs", "queue_free")

func _on_enemy_spawn_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $EnemySpawn
	mob.position = mob_spawn_location.position
	add_child(mob)


func spawn_mobs(mob_count: int, area2d: Area2D):
	# Ottieni il CollisionShape2D
	var collision_shape = null
	var local_point = Vector2.ZERO
		# Ottieni la forma del rettangolo
	#var rect = area.get_child(0).shape.get_rect()
	#var shape = area.get_child(0).shape
	
	
	for child in area2d.get_children():
		if(child is CollisionShape2D):
			collision_shape = child
			break
		elif(child is CollisionPolygon2D):
			collision_shape = child
			break
			
	
	if(collision_shape is CollisionShape2D):
		var cr = collision_shape.shape
		var extents = cr.extents # Queste sono le half-width e half-height
		var rect_position = position - extents  # Calcola l'angolo in alto a sinistra
		var rect_size = extents * 2  # Le dimensioni effettive del rettangolo
		var rect = cr.get_rect()
		
		for i in range(mob_count):
			var mob = mob_scene.instantiate()
			mob.position = Vector2(
				randf_range(rect_position.x, rect_position.x + rect_size.x),
				randf_range(rect_position.y, rect_position.y + rect_size.y)
			)
			collision_shape.add_child(mob)
	elif collision_shape is CollisionPolygon2D:
			var cp = collision_shape.polygon
			var random_vertex_index = randi() % cp.size()
			var mob = mob_scene.instantiate()
			mob.position = cp[random_vertex_index]
			#TODO: capire perchè spawnano in un solo punto
			collision_shape.add_child(mob)
			


