shader_type spatial;

uniform float time_scale = 3;
uniform float side_to_side = 0.5;
uniform float pivot = 0.5;

//time_scale is a uniform float
void vertex() {
	float time = TIME * time_scale;
	VERTEX.x += cos(time) * side_to_side;
	//angle is scaled by 0.1 so that the fish only pivots and doesn't rotate all the way around
	//pivot is a uniform float
	float pivot_angle = cos(time) * 0.1 * pivot;
	mat2 rotation_matrix = mat2(
		vec2(cos(pivot_angle), -sin(pivot_angle)), 
		vec2(sin(pivot_angle), cos(pivot_angle))
	);
	VERTEX.xz = rotation_matrix * VERTEX.xz;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
