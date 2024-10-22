extends "res://scripts/base_player.gd"

var bp: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	._init(health=150, atk_speed=150.0, defense=0.8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
