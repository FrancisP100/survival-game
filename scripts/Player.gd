extends Personagem #Classe Personagem

const DAMAGE_RATE = 5.0

func _ready():
	health = 100.0
	speed = 600.0
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		animator.play("sword_atk1")
#	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") #Movimento em 8 direcções
#	velocity = direction * SPEED
#	move_and_slide(velocity)
#	if velocity.x > 0.0: #direita
#		set_animation("walk")
#		flip(false)
#	elif velocity.x < 0.0: #esquerda
#		set_animation("walk")
#		flip(true)
#	elif velocity.y != 0: #Cima ou baixo
#		set_animation("walk")
#	else:
#		set_animation("idle")
#	$Health.value = health
#	#var overlapping_mobs = $HurtBox.get_overlapping_bodies()
#	#if overlapping_mobs.size() > 0:
		#health -= DAMAGE_RATE * overlapping_mobs.size() * delta

