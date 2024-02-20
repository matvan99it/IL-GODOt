shader_type spatial;

uniform sampler2D noise;
uniform float height_scale = 0.5;
const float MULTI = 4.0;

void vertex() {
	// Called for every vertex the material is visible on.
	// VERTEX.y += cos(VERTEX.x * MULTI) * sin(VERTEX.z * MULTI);
	float height = texture(
		noise, 
		VERTEX.xz / 2.0 + 0.5
		).x;
	VERTEX.y += height;
	
	
	
}
