extends KinematicBody2D

class_name Personagem

enum {IDLE , WALK , RUN}

signal health_is_over

onready var animsprite: AnimatedSprite = get_node("AnimatedSprite")
onready var animator: AnimationPlayer = get_node("AnimationPlayer")
onready var debug_label = get_node("Debug")

var animation := ""
var health : float
var velocity
var direction
var state : int = 0
var speed : float
var sprint : bool = false

#-------------------------Zona da Animação-------------------------------------------------------#


func set_animation(anim: String) -> void:
	if animation != anim:
		animation = anim
		animator.play(animation)

func play_attack_animation():
	animator.play("attack")

func set_flip():
	if velocity.x > 0.0:
		animsprite.flip_h = false
	elif  velocity.x < 0.0:
		animsprite.flip_h = true


#-------------------------Zona das Funções-------------------------------------------------------#


func stop_movement():
	velocity = Vector2.ZERO
	
func _physics_process(delta) -> void:
	$Health.value = health
	direction = Input.get_vector("move_left", "move_right","move_up","move_down") #Movimento em 8 direcções
	
	if health <= 0:
		emit_signal("health_is_over")
	if Input.is_action_pressed("sprint"):
		sprint = true
	else:
		sprint = false
	
	match state:
		IDLE : idle_state()
		WALK : walk_state()
		RUN  : run_state()


#-------------------------Zona da State Machine----------------------------------------------------#
	
func _enter_state(new_state) -> void :
	state = new_state
	
func idle_state() -> void :
	$Health.value = health
	set_animation("idle")
	stop_movement()
	debug_label.text = "IDLE"
	velocity = direction * speed
	move_and_slide(velocity)
	if velocity and sprint:
		_enter_state(RUN)
	elif velocity:
		_enter_state(WALK)

func walk_state() -> void :
	$Health.value = health
	velocity = direction * speed
	move_and_slide(velocity)
	set_animation("walk")
	set_flip()
	debug_label.text = "WALK"
	if sprint:
		_enter_state(RUN)
	elif !velocity:
		_enter_state(IDLE)

func run_state() -> void :
	$Health.value = health
	velocity = direction * speed
	move_and_slide(velocity)
	set_animation("run")
	set_flip()
	debug_label.text = "RUN"
	if !sprint:
		_enter_state(WALK)
	elif !velocity:
		_enter_state(IDLE)

#-------------------------Zona da State Machine----------------------------------------------------#


#-------------------------Zona dos Sinais----------------------------------------------------------#

#Programe aqui 

#-------------------------Zona dos Sinais----------------------------------------------------------#
