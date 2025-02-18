extends Node2D

"""
Il player una volta che sconfigge il 90% dei nemici cioè almeno il 50% dei minion e il miniboss conquista la zona 
che diventa una nuova zona da conquistare per i nemici o fa spawnare un BOSS


"""


var sp: sesso_pazzo
var screen_size
@export var mob_scene: PackedScene
@export var miniboss_scene: PackedScene
@export var boss_scene: PackedScene
@export var enemy_count: int = 20
var player_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	
	screen_size = get_viewport_rect().size
	sp = get_node("/root/SessoPazzo")
	match sp.scelta:
		"warrior":
			player_scene = preload("res://scenes/weapons_characters/warrior.tscn")
		"lancer":
			player_scene = preload("res://scenes/weapons_characters/lancer.tscn")
	
	
	spawn_mobs(enemy_count, $Stanza2)
	spawn_mobs(enemy_count, $Stanza3)
	spawn_mobs(enemy_count, $Stanza4)
	spawn_miniboss()
	spawnPLayer()
	
	print("Spawn pos ", $SpawnPlayer.position, "; glob ", $SpawnPlayer.global_position)
	
	
	$sliderAnimation.play("slide")
	new_game()

func new_game():
	get_tree().call_group("mobs", "queue_free")

func _on_enemy_spawn_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $EnemySpawn
	mob.position = mob_spawn_location.position
	add_child(mob)


func spawn_miniboss():
	var mb = miniboss_scene.instantiate()
	print($Marker2D.position)
	mb.position = $Marker2D.position
	print(mb.position)

func spawn_mobs(mob_count: int, area2d: Area2D):
	# Ottieni il CollisionShape2D
	var collision_shape = null
	var local_point = Vector2.ZERO
	
	
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
			#bananana
	elif collision_shape is CollisionPolygon2D:
		for i in range(mob_count):
			var random_position = get_random_point_in_polygon(collision_shape.get_polygon())
			if random_position != Vector2.ZERO:
				var mob = mob_scene.instantiate()
				mob.position = random_position
				collision_shape.add_child(mob)


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


func spawnPLayer():
	var p = player_scene.instantiate()
	p.position = position.clamp($SpawnPlayer.position, screen_size)
	
	var rm: RemoteTransform2D = RemoteTransform2D.new()
	rm.remote_path = $Camera2D.get_path()
	p.add_child(rm)
	$".".add_child(p)
	print("IL player dovrebe essere a ", p.position, " il glob ", p.global_position)
