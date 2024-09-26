extends KinematicBody2D

class_name Mobs

enum {IDLE , FOLLOW , CHASE , ATK, DIE}

onready var debug_label = get_node("Debug")
onready var animsprite: AnimatedSprite = get_node("AnimatedSprite")
onready var animator: AnimationPlayer = get_node("AnimationPlayer")

var animation := ""
var velocity : Vector2
var direction : Vector2
var health := 100.0
var state : int = 0
var speed : float
var sprint : bool = false
var damage

onready var player: KinematicBody2D = get_node("../Player")


#-------------------------Zona da Animação---------------------------------------------------------#

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

#-------------------------Zona da Animação---------------------------------------------------------#

#-------------------------Zona das Funções---------------------------------------------------------#

func stop_movement():
	velocity = Vector2.ZERO
	
func is_in_range(group: String) -> bool:
	var areas = $Range.get_overlapping_areas()
	for area in areas:
		if area.is_in_group(group):
			return true
	return false

func take_damage(damage_taked):
	health -= damage_taked
	stop_movement()
	if health <= 0:
		_enter_state(DIE)
	else:
		set_animation("hurt")

func _physics_process(delta) -> void:
	
#	if Input.is_action_pressed("sprint"):
#		sprint = true
#	else:
#		sprint = false

	match state:
		IDLE : idle_state()
		FOLLOW : follow_state()
		CHASE  : chase_state()
		ATK : atk_state()
		DIE : die_state()

func _process(delta):
	direction = global_position.direction_to(player.global_position) #Calcula a direção ao player :D
	set_flip()
	$Health.value = health
	if health <= 0:
		_enter_state(DIE)
	
	
#-------------------------Zona das Funções---------------------------------------------------------#


#-------------------------Zona da State Machine----------------------------------------------------#
	
func _enter_state(new_state) -> void :
	state = new_state
	
func idle_state() -> void :
	set_animation("idle")
	stop_movement()
	debug_label.text = "IDLE"
	velocity = direction * speed
	move_and_slide(velocity)
	if velocity and sprint:
		_enter_state(CHASE)
	elif velocity:
		_enter_state(FOLLOW)

func follow_state() -> void :
	set_animation("walk")
	velocity = direction * speed
	move_and_slide(velocity)
	debug_label.text = "FOLLOW"
	
	if sprint:
		_enter_state(CHASE)
	elif !velocity:
		_enter_state(IDLE)
	
func chase_state() -> void :
	velocity = direction * speed
	move_and_slide(velocity)
	set_animation("run")
	debug_label.text = "CHASE"
	if !sprint:
		_enter_state(FOLLOW)
	elif !velocity:
		_enter_state(IDLE)
		
func atk_state() -> void :
	$Attack_Speed.start()
	var players = $Range.get_overlapping_areas()
	for player in players:
		if player.is_in_group("Player"):
			player.get_parent().health -= damage
	set_physics_process(false)
	if health <= 0:
		_enter_state(DIE)
	debug_label.text = "ATTACK"
	stop_movement()
	set_animation("attack")
	
func die_state():
	$Health.value = health
	debug_label.text = "DIE"
	$CollisionShape2D.disabled = true
	set_animation("die")
	yield(get_tree().create_timer(0.9),"timeout")
	queue_free()

#-------------------------Zona da State Machine----------------------------------------------------#

#-------------------------Zona dos Sinais ---------------------------------------------------------#


func _on_Range_area_entered(area):
	if area.is_in_group("Player"):
		_enter_state(ATK)

func _on_Range_area_exited(area):
	if area.is_in_group("Player"):
		$Range.players_in_range.pop_back()
		_enter_state(FOLLOW)

func _on_Attack_Speed_timeout():
	if $Range.players_in_range.size() > 0:
		_enter_state(ATK)


#-------------------------Zona dos Sinais ---------------------------------------------------------#


#-------------------------------------------------Analysing----------------------------------------#

# overlapping_areas = $Area2D.get_overlapping_areas()
#	for area in overlapping_areas:
#		if area.is_in_group("Laser_AoE"):
#			health -= area.damage * delta
#			healthbar.visible = true
#	if health <= 0:
#		queue_free()
#		get_parent().get_parent().money += 10

#func _on_Area2D_area_entered(area):
#	if area.is_in_group("Projectile"):
#		hurt(area)
#	elif area.is_in_group("AoE"):
#		AoE_hurt(area.damage)
	
#func hurt(projectile : Area2D):
#	if projectile.is_in_group("Projectile"):
#		projectile.impact()
#		health -= projectile.damage
#		healthbar.visible = true
#
#func AoE_hurt(damage):
#	health -= damage
#	healthbar.visible = true
	
#-------------------------------------------------Analysing----------------------------------------#



