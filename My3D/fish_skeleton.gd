extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range($School.multimesh.instance_count):
		var position = Transform3D()
		position = position.translated(Vector3(randf() * 100 - 50, randf() * 50 - 25, randf() * 50 - 25))
		$School.multimesh.set_instance_transform(i, position)
