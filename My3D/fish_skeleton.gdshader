shader_type spatial;

uniform float time_scale = 3;
uniform float side_to_side = 0.5;
uniform float pivot = 2.0;
uniform float wave = 0.2;
uniform float twist = 0.1;
uniform float mask_black = 0.5;
uniform float mask_white = 0.6;

//time_scale is a uniform float
void vertex() {
	float body = (VERTEX.z + 1.0) / 2.0; //for a fish centered at (0, 0) with a length of 2
	float time = TIME * time_scale;
	VERTEX.x += cos(time) * side_to_side;
	//wave is a uniform float
	VERTEX.x += cos(time + body) * wave;
	//angle is scaled by 0.1 so that the fish only pivots and doesn't rotate all the way around
	//pivot is a uniform float
	float pivot_angle = cos(time) * 0.1 * pivot;
	mat2 rotation_matrix = mat2(
		vec2(cos(pivot_angle), -sin(pivot_angle)), 
		vec2(sin(pivot_angle), cos(pivot_angle))
	);
	VERTEX.xz = rotation_matrix * VERTEX.xz;
	//twist is a uniform float
	float twist_angle = cos(time + body) * 0.3 * twist;
	mat2 twist_matrix = mat2(
		vec2(cos(twist_angle), -sin(twist_angle)), 
		vec2(sin(twist_angle), cos(twist_angle))
	);
	
	VERTEX.xy = twist_matrix * VERTEX.xy;
	//mask_black and mask_white are uniforms
	float mask = smoothstep(mask_black, mask_white, 1.0 - body);
	//wave motion with mask
	VERTEX.x += cos(time + body) * mask * wave;
	//twist motion with mask
	VERTEX.xy = mix(VERTEX.xy, twist_matrix * VERTEX.xy, mask);
	
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
