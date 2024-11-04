extends Area2D
#This has to be for every area2d created
class_name atk_def_area

"""
N.B.: QUESTA DEVE ESSERE LA LOGICA DI GIOCO

Un area può essere conquistata da alleati o nemici, o essere neutra conquistabile o neutra disabilitata (PER ORA NON ESITONO AREE CHE RIMANGONO FISSE)

Per essere conquistata bisogna aumentare la forza alleata oltre il 60/70/80 % (poi vedo)
Per poterlo fare bisogna che le unità alleate entrino nell'area o si sconfiggaono quelli che già posseggono l'area

Un area deve essere composta dai minion e un miniboss e un qualcosa per farli comparire

"""

enum area_state {
	ALLIED = 0,
	ENEMIES = 1,
	NEUTRO = 2,
	LOCKED = 3 # area disattivata e non conquistabile
}

var initial_state = area_state.NEUTRO

func on_area_entered(): #Check per area neutra o per triggerare chiunque si trovi nell'area
	pass

func capture_area(state: int = 2): #Cambia lo stato dell'area
	match state:
		0: initial_state = area_state.ALLIED
		1: initial_state = area_state.ENEMIES
		2: initial_state = area_state.NEUTRO
		3: initial_state = area_state.LOCKED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
