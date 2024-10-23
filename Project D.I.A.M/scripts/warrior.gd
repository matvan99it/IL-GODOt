extends player_base

var bp: CharacterBody2D

func _ready():
	_init(100, 0.3, 5)
	$PAttackCooldown.wait_time *= ATK_SPEED

func _physics_process(delta):
	movimenti(delta)
		
	#ATTACCATI AL TACATA
	if Input.is_action_just_pressed("attack") and not attack_cooldown:
	
		is_attacking = true
		
		if mob != null:
			if not mob.is_connected("attacked", Callable(self, "doAttack")):
				mob.attacked.connect(doAttack)
			else:
				doAttack()
		else:
			doAttack()


func doAttack():
	print("NON BANNANA")
	if not attack_cooldown:
	#if(direction)
		if right:
			if(up):
				attack_animation.play("attack_down")
				up = false
			else:
				attack_animation.play("attack_up")
				up = true
		else:
			if(up):
				attack_animation.play("attack_down_left")
				up = false
			else:
				attack_animation.play("attack_up_2")
				up = true
		
		$PAttackCooldown.start()
		attack_cooldown = true
		if mob != null:
			mob.health -= 200
			mob.flashan.play("flash_mob")
		"""
		if enemy_in_range and mob != null:
			#mob.health -= 200
			mob.flashan.play("flash_mob")
			if(mob.health <= 0):
				remaining_mob.erase(mob)
				print("b", remaining_mob.size(), " ", remaining_mob)
				if(not remaining_mob.is_empty()):
					print("Rimnagono ", remaining_mob.size(), " e sono ", remaining_mob)
					print("Non vuoto")
					mob = remaining_mob[0]
		"""



func _on_player_hitbozz_body_entered(body):
	player_hitbox(body, true)


func _on_player_hitbozz_body_exited(body):
	player_hitbox(body, false)


func _on_weapon_area_detection_body_entered(body):
	weapon_area(body)
	

#TODO: queste 2 vanno generalizzzate un attimo
func _on_p_attack_cooldown_timeout():
	attack_cooldown = false
	is_attacking = false


func _on_after_damage_invincibility_timeout():
	is_invincible = false

