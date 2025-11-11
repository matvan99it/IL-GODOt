extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	print(body.name)
	if body.is_in_group("Player"):
		print("MAPPORCODIO")
		var image_overlay = body.get_node("CameraPivot/jumpscare")
		print(image_overlay)
		image_overlay.visible = true
		await get_tree().create_timer(2.0).timeout
		image_overlay.visible = false
