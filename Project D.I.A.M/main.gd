extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$sliderAnimation.play("slide")
	$circleAnimation.play("rotatoria_pazza")

