extends Node2D

@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.


# Numero di mob da spawnare
var mob_count = 10000

func _ready():
	# Spawna i mob all'interno dell'Area2D
	spawn_mobs2()


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

# Funzione per spawnare i mob all'interno del CollisionPolygon2D
func spawn_mobs2():
	# Ottieni il nodo CollisionPolygon2D
	var collision_polygon = $Area2D/pippo
	if collision_polygon:
		# Ottieni i vertici del poligono
		var polygon_points = collision_polygon.get_polygon()
		
		for i in range(mob_count):
			# Genera una posizione casuale all'interno del poligono
			var random_position = get_random_point_in_polygon(polygon_points)

			if random_position != null:
				# Istanziamo un nuovo mob
				var mob_instance = mob_scene.instantiate()
				mob_instance.position = random_position

				# Aggiungi l'istanza del mob alla scena
				collision_polygon.add_child(mob_instance)

# Funzione per generare una posizione casuale all'interno di un poligono
func get_random_point_in_polygon(polygon_points: PackedVector2Array) -> Vector2:
	# Trova la bounding box del poligono
	var min_x = polygon_points[0].x
	var max_x = polygon_points[0].x
	var min_y = polygon_points[0].y
	var max_y = polygon_points[0].y
	
	for point in polygon_points:
		if point.x < min_x:
			min_x = point.x
		if point.x > max_x:
			max_x = point.x
		if point.y < min_y:
			min_y = point.y
		if point.y > max_y:
			max_y = point.y

	# Genera punti casuali fino a quando ne troviamo uno dentro il poligono
	while true:
		var random_point = Vector2(
			randf_range(min_x, max_x),
			randf_range(min_y, max_y)
		)

		# Controlla se il punto casuale è dentro il poligono
		if is_point_in_polygon(random_point, polygon_points):
			return random_point

	return Vector2.ZERO

# Funzione per verificare se un punto è all'interno di un poligono
func is_point_in_polygon(point: Vector2, polygon_points: PackedVector2Array) -> bool:
	var inside = false
	var j = polygon_points.size() - 1
	for i in range(polygon_points.size()):
		var vi = polygon_points[i]
		var vj = polygon_points[j]
		
		if ((vi.y > point.y) != (vj.y > point.y)) and (point.x < (vj.x - vi.x) * (point.y - vi.y) / (vj.y - vi.y) + vi.x):
			inside = not inside
		j = i
	return inside
