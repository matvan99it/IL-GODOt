extends Node2D

@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.


# Numero di mob da spawnare
var mob_count = 10000

func _ready():
	# Spawna i mob all'interno dell'Area2D
	spawn_mobs()


func spawn_mobs():
	# Ottieni il CollisionShape2D
	var area = $Area2D
	var collision_shape = $Area2D/CollisionShape2D
		# Ottieni la forma del rettangolo
	var rect = area.get_child(0).shape.get_rect()
	var shape = area.get_child(0).shape
	
	var extents = shape.extents # Queste sono le half-width e half-height
	var rect_position = position - extents  # Calcola l'angolo in alto a sinistra
	var rect_size = extents * 2  # Le dimensioni effettive del rettangolo
	print("REKT: ", rect_position)
	print("EXTENTS: ", extents)
	print("SIZE", rect_size)
	print("PUNTO INIZIALE: ", rect.position.x, " ", rect.position.y)
	print("AREA: ", rect.get_area())
	print("PUNTO FINALE: ", rect.position.x + rect.size.x, " ", rect.position.y + rect.size.y)
	for i in range(mob_count):
		
		var local_point = Vector2(
			randf_range(rect_position.x, rect_position.x + rect_size.x),
			randf_range(rect_position.y, rect_position.y + rect_size.y)
		)
		
			# Istanziamo un nuovo mob
		var mob = mob_scene.instantiate()
		mob.position = local_point

		collision_shape.add_child(mob)


func spawn_mobs2():
	# Ottieni il CollisionShape2D
	var collision_shape = $CollisionShape2D
	if collision_shape:
		# Ottieni la forma del rettangolo
		var rectangle_shape = collision_shape.shape
		
		# Calcola le extents
		var extents = rectangle_shape.extents  # Queste sono le half-width e half-height
		
		# Calcola la posizione dell'angolo in alto a sinistra del rettangolo
		var rect_position = position - extents
		
		# Calcola le dimensioni effettive del rettangolo
		var rect_size = extents * 2  # Le dimensioni effettive del rettangolo

		# Stampa le dimensioni e la posizione per il debug
		print("Rect Position: ", rect_position)
		print("Rect Size: ", rect_size)

		for i in range(mob_count):
			# Genera una posizione casuale all'interno del rettangolo
			var random_position = Vector2(
				randf_range(rect_position.x, rect_position.x + rect_size.x),
				randf_range(rect_position.y, rect_position.y + rect_size.y)
			)

			# Istanziamo un nuovo mob
			var mob_instance = mob_scene.instantiate()
			mob_instance.position = random_position

			# Aggiungi l'istanza del mob alla scena
			$Area2D/CollisionShape2D.add_child(mob_instance)
