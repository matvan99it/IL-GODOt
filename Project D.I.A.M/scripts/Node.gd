extends Node2D

var speed = 0.8  # rotation speed (in radians)
var radius = 300  # desired orbit radius
# Called when the node enters the scene tree for the first time.
func _ready():
	$".".position = Vector2(radius, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += speed * delta
