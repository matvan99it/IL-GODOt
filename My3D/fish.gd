extends Skeleton3D


const TIME = 2
const SIDE_TO_SIDE = 5
const time_scale = 0.1
const wave = 1
const pivot = 1
const twist = 1
const mask_black = Color.BLACK.a
const mask_white = Color.WHITE.a

var time: float
var pivot_angle: float
var body = Vector3.ZERO
var VERTEX


func _ready():
	VERTEX = get_node("FishMesh").position
	


func _process(delta):
	time = TIME * time_scale
	VERTEX.x = cos(time) * SIDE_TO_SIDE
	#angle is scaled by 0.1 so that the fish only pivots and doesn't rotate all the way around
	#pivot is a uniform float
	var pivot_angle: float = cos(time) * 1 * pivot;
	var rotation_matrix = [ 
		Vector2(
			cos(pivot_angle), -sin(pivot_angle)
		), 
		Vector2(
			sin(pivot_angle), cos(pivot_angle)
		) 
	];
	VERTEX.xz = rotation_matrix * VERTEX.xz;
	var body: float = (VERTEX.z + 1.0) / 2.0; #for a fish centered at (0, 0) with a length of 2
	#wave is a uniform float
	VERTEX.x += cos(time + body) * wave;
	
	#twist is a uniform float
	var twist_angle: float = cos(time + body) * 0.3 * twist;
	var twist_matrix = [
		Vector2(
			cos(twist_angle), -sin(twist_angle)
		),
		Vector2(
			sin(twist_angle), cos(twist_angle)
		)
	]
	VERTEX.xy = twist_matrix * VERTEX.xy;
	# mask_black and mask_white are uniforms
	var mask: float = smoothstep(mask_black, mask_white, 1.0 - body);
	# wave motion with mask
	VERTEX.x += cos(time + body) * mask * wave;
	# twist motion with mask
	VERTEX.xy = mix(VERTEX.xy, twist_matrix * VERTEX.xy, mask);

func get_sine():
	return abs(sin(time * 1) * 1)
