extends Node
class_name sesso_pazzo

var scelta: String = "warrior"


#N.B.:
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
#TODO: creare una specie di trama/dialoghi vari
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

