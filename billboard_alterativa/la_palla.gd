extends CharacterBody3D

#@export var player: PackedScene


#@onready var player: PackedScene = preload("res://character_body_3d.tscn")

var player_from_path = null
var player_from_scene = null

@export var player_path : NodePath

@onready var player_scene = preload("res://character_body_3d.tscn")


const SPEED = 5.0


func _ready():
	player_from_scene = player_scene.instantiate()
	player_from_path = get_node(player_path)
	print(player_from_scene)
	print(player_from_path)
	#get_node(player_path)

func _physics_process(delta):
	
	var pos_from_scene = player_from_scene.global_position #<- Vector3.ZERO
	var pos_from_path = player_from_path.global_position # <- questo va
	
	print("SCENE: ", pos_from_scene)
	print("PATH: ", pos_from_path)
	
	#var player_pos = player.global_position
	look_at(
		Vector3(pos_from_path.x, pos_from_path.y, pos_from_path.z),
		Vector3.DOWN
	)
	"""
	-x fa girare dal lato opposto a dove si va
	-y non ho capito la differenza
	-z stroce tutto
	"""

	move_and_slide()
