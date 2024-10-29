extends player_base

var bp: CharacterBody2D

func _ready():
	_init(100, 0.4, 5)
	$PAttackCooldown.wait_time *= ATK_SPEED




func doAttack():
	print("NON BANNANA")
	if not attack_cooldown:
		#if(direction)
		if right:
			attack_animation.play("attack_LR")
		else:
			attack_animation.play("attack_RL")

		
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



