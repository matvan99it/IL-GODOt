extends Node2D

func _ready():
	var shader_material = ShaderMaterial.new()
	shader_material.shader = preload("res://moving_platform.gdshader")
	shader_material.set_shader_param("seed", randi())  # Imposta un valore casuale come seed
	self.material = shader_material
	
