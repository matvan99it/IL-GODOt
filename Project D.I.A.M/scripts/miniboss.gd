extends base_enemy



func _ready():
	scale.x *= 2
	scale.y *= 2
	_init(150, -1, 10, 30, false)
