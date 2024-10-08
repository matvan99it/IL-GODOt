extends Node2D

@export var mob_scene: PackedScene
# Called when the node enters the scene tree for the first time.


# Numero di mob da spawnare
var mob_count = 10

func _ready():
	# Spawna i mob all'interno dell'Area2D
	spawn_mobs()

func spawn_mobs():
	# Ottieni il CollisionShape2D
	var area = $Area2D
		# Ottieni la forma del rettangolo
	var rect = area.get_child(0).shape.get_rect()
		
	print("DIMENZIONI")
	print("position:")
	print(rect.position)
	print("area:")
	print(rect.get_area())
	for i in range(mob_count):
		var x = randf_range(area.position.x, rect.position.x + rect.size.x)
		var y = randf_range(area.position.y, rect.position.y + rect.size.y)
		var local_point = Vector2(x,y)
		print("PORCODDIO")
		print(local_point)
			# Istanziamo un nuovo mob
		var mob = mob_scene.instantiate()
		mob.position = local_point

		area.add_child(mob)
