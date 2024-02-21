shader_type spatial;

uniform sampler2D noise;
uniform float height_scale = 0.5;
uniform sampler2D normalmap;

render_mode specular_toon; //, diffuse_toon;

varying vec2 tex_position;

float wave(vec2 position) {
	position += texture(noise, position / 10.0).x * 1.0 - 1.0;
	vec2 wv = 1.0 - abs(sin(position));
	return pow(1.0 - pow(wv.x * wv.y, 0.65), 1.0);
}

float height(vec2 position, float time) {
	//vec2 offset = 0.01 * cos(position + time);
	//float h = wave(position);
	//return h;// texture(noise, (position / 10.0) - offset).x; // Scaling factor is based on mesh size (this PlaneMesh is 10×10).

  float d = wave((position + time) * 0.4) * 0.3;
  d += wave((position - time) * 0.3) * 0.3;
  d += wave((position + time) * 0.5) * 0.2;
  d += wave((position - time) * 0.6) * 0.2;
  return d;
}



void vertex() {
	// Called for every vertex the material is visible on.
	// VERTEX.y += cos(VERTEX.x * MULTI) * sin(VERTEX.z * MULTI);
	/*tex_position = VERTEX.xz / 8.0 + 0.5;
	float height = texture(
		noise,
		tex_position
	).x;
	VERTEX.y += height * height_scale;*/
	vec2 pos = VERTEX.xz;
	float k = height(pos, TIME);
	VERTEX.y = k;
	NORMAL = normalize(
		vec3(
			k - height(
				pos + vec2(0.1, 0.0), 
				TIME
			), 
			0.1, 
			k - height(
				pos + vec2(0.0, 0.1), 
			TIME)
		)
	);
}

void fragment() {
	//NORMAL_MAP = texture(normalmap, tex_position).xyz;
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
	RIM = 0.2;
	METALLIC = 0.01;
	ROUGHNESS = 0.01 * (1.0 - fresnel);
	ALBEDO = vec3(0.01, 0.03, 0.05) + (0.1 * fresnel);
	
	

}


