extends Node






#N.B.:
#TODO: migliorare il combat system
#TODO: implementare un sistema di combo minimo
#TODO: imparare bene i tileset e le tilemap per fare le mappe
#TODO: creare le classi per tipologia di nemico
#TODO: aggiungere una mini pausa per i danni presi e subiti e incrementale in base al tipo di danno
#TODO: aggiungere una specie di knockbck per i nemici più piccoli
#TODO: creare dei bozzetti per le mappe
#TODO: imparare ad usare aeprite per fare animazioni e grafiche
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
