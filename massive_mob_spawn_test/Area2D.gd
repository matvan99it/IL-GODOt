extends Area2D


@export var MOB_SCENE: PackedScene
# Percorso alla scena del mob

# Numero di mob da spawnare
var mob_count = 10

func _ready():
	# Spawna i mob all'interno dell'Area2D
	spawn_mobs()

func spawn_mobs():
	# Ottieni il CollisionShape2D
	var collision_shape = $CollisionShape2D
	
	# Ottieni la forma del rettangolo
	var rectangle_shape = collision_shape.shape
		
	# Calcola il punto di origine del rettangolo
	var rect_position = position - rectangle_shape.extents
	var rect_size = rectangle_shape.extents * 2
		
	for i in range(mob_count):
		# Genera una posizione casuale all'interno del rettangolo
		var random_position = Vector2(
			randf_range(rect_position.x, rect_position.x + rect_size.x),
			randf_range(rect_position.y, rect_position.y + rect_size.y)
		)

		# Istanziamo un nuovo mob
		var mob_instance = MOB_SCENE.instantiate()
		mob_instance.position = random_position

		# Aggiungi l'istanza del mob alla scena
		self.add_child(mob_instance)
