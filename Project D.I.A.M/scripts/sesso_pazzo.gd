extends Node
class_name sesso_pazzo

var scelta: String = "warrior"


#N.B.:
#TODO: implementare il sistema di cattura area
#TODO: creare nuovi pg/armi e modificare le hitbozz
#TODO: craere un pause_menu in game
#TODO: migliorare il combat system per gestire più mob
#TODO: migliorare le classi di miniboss e boss
#TODO: implementare un sistema di combo minimo
#TODO: imparare bene i tileset e le tilemap per fare le mappe
#TODO: aggiungere un knock al player/mob dopo tot attacchi
#TODO: creare stili diversi(pg o equip)
#TODO: creare dei bozzetti per le mappe
#TODO: imparare ad usare aeprite per fare animazioni e grafiche
#TODO: migliorare main menu con delle animazionie grafiche
#TODO: creare un modo per salvare i dati
#TODO: creare una specie di trama/dialoghi vari(opzionale)
#TODO: aggiungere suoni(opzionale per ora)


"""
Tutorial segnali fatti bene

Node2D -> s2.gd
|	Area2D -> s1.gd
	|	CollissionShape

L'idea è quando il mouse entra nell'Area2D si chiude tutto 
perchè viene emesso il segnale e quel segnale e poi legato ad una funzione nel Node2D

#### s1.gd ####
extends Area2D

signal DestroyTheWorld

func _ready():
	connect("mouse_entered", oogabooga)

func oogabooga():
	emit_signals("DestroyTheWorld") || DestroyTheWorld.emit()



#### s2.gd ####
extends Node2D

func _ready():
	$Area2D.connect("DestroyTheWorld", destroy)

func destroy():
	get_tree().quit()


"""

#TODO: implementare meglio questo save
"""
func save(
	pos_x: float,
	pos_y: float,
	
	
):
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"attack" : attack,
		"defense" : defense,
		"current_health" : current_health,
		"max_health" : max_health,
		"damage" : damage,
		"regen" : regen,
		"experience" : experience,
		"tnl" : tnl,
		"level" : level,
		"attack_growth" : attack_growth,
		"defense_growth" : defense_growth,
		"health_growth" : health_growth,
		"is_alive" : is_alive,
		"last_attack" : last_attack
	}
	return save_dict"""
