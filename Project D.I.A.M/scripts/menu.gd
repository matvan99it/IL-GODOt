extends CanvasLayer

@export var game_scene: PackedScene

enum pg{
	warrior, lancer
}


func load_scene(pers: String):
	sesso_pazzo.scelta = pers
	get_tree().change_scene_to_packed(game_scene)


func _on_lancer_b_pressed(): # far partire con il lanciere
	load_scene("lancer")


func _on_warrior_b_pressed(): # far partire con il guerriero
	load_scene("warrior")
