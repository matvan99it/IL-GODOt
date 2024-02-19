extends Node2D

var screen 
var rec1
var rec2
var contain
var color = 0
var bak = []

# Called when the node enters the scene tree for the first time.
func _ready():
	screen = [0, 0, get_viewport_rect().size.x, get_viewport_rect().size.y]
	contain = [screen]
	set_process_input(true)

func rect(contain):
	bak.clear()
	for rec in contain:
		randomize()
		if(rec[2] > rec[3]):
			var w = round(randf_range(.3, .7)*rec[2])
			rec1 = [rec[0], rec[1], w, rec[3]]
			rec2 = [rec[0]+w, rec[1], rec[2]-w, rec[3]]
		else:
			var h = round(randf_range(.3, .7)*rec[3])
			rec1 = [rec[0], rec[1], rec[2], h]
			rec2 = [rec[0], rec[1]+h, rec[2], rec[3]-h]
		bak.append(rec1)
		bak.append(rec2)
	contain.clear()
	for r in bak: 
		contain.append(r)
		
	print(contain)
	
	
func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		rect(contain)
		queue_redraw()

func _draw():
	for r in contain:
		color = Color(
			randf_range(.1, .8),
			randf_range(.1, .8),
			randf_range(.1, .8),
			)
		draw_rect(Rect2(r[0]+1, r[1]+1, r[2]-2, r[3]-2), color)
