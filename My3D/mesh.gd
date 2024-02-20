extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh.material.set_instance_shader_parameter("height_scale", 5.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
