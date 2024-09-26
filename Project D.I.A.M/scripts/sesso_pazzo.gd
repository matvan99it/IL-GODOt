extends Node






#N.B.:
#TODO: fare bene il combat system
#TODO: creare le classi per tipologia di nemico
#TODO: implementare combat system
#TODO: aggiungere shader lampeggiante per il danno inferto e subito in base al tipo di nemico
#TODO: aggiungere una mini pausa per i danni presi e subiti e incrementale in base al tipo di danno
#TODO: aggiungere una specie di knockbck per i nemici più piccoli
#TODO: sistemare le piattaforme in modo che possa gestirle anche da codice e migliorare le grafiche e gli allineamenti

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
