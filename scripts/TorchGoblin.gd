extends Mob #Classe Mob

const SPEED = 150


func _ready():
	health = 30.0

func _physics_process(_delta):
	direction = global_position.direction_to(player.global_position) #Calcula a direção ao player :D
	velocity = direction * SPEED
	move_and_slide(velocity)
	if velocity.x > 0.0 : # direita
		set_animation("walk")
		flip(false)
	elif velocity.x < 0.0: # esquerda
		set_animation("walk")
		flip(true)
	elif velocity.y != 0: #Cima ou baixo
		set_animation("walk")
	else:
		set_animation("idle")

func take_damage(damage):
	health -= damage
	set_animation("hurt")
	if health == 0:
		set_physics_process(false)
		set_animation("die")
		yield(get_tree().create_timer(0.8),"timeout")
		queue_free()
		
