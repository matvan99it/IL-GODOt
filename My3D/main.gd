extends Node
@export var fish_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob = fish_scene.instantiate()
	add_child(mob)


