extends MeshInstance2D

func _ready():# Assicurati che il nodo abbia un ShaderMaterial
	if self.material is ShaderMaterial:
		var shader_material = self.material as ShaderMaterial
		# Imposta il parametro 'seed' con un valore casuale
		shader_material.set("shader_parameter/seed", randf() * 100.0)  # Valore casuale tra 0 e 100

