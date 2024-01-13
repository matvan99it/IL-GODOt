extends Sprite2D

var speed = 400
var angular_speed = PI
# var direction = 0

#As signals represent events that just occurred, we generally use an action verb in the past tense in their names.
signal health_depleted
signal health_changed(old_val, new_val)

var health = 10

func _init(): # funzione dell'engine per settare
	print("Hello world")

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += angular_speed * delta
	
	var velocity = Vector2.UP.rotated(rotation) * speed #Vector2.ZERO
	
	position += velocity * delta
	
	"""
	#var direction = 0
	#if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
		
	rotation += angular_speed * direction * delta
		
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	
	position += velocity * delta
	"""

func _on_button_pressed():
	set_process(not is_processing())
	
	
func _on_timer_timeout():
	visible = not visible


func take_damage(amount):
	var old = health
	health -= amount
	health_changed.emit(old, health)


func _on_health_depleted():
	pass # Replace with function body.


func _on_health_changed(old_val, new_val):
	if(new_val <= 0):
		health_depleted.emit()
