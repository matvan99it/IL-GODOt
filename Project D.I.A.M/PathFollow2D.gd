extends PathFollow2D

const SPEED = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += delta * SPEED
