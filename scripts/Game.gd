extends Node2D

onready var path_follow = get_node("Player/Path2D/PathFollow2D")
onready var gameover = get_node("GameOver")
onready var mob_count := 0
onready var new_mob
onready var mob_cap := 5



func _ready():
#	spawn_mob()
	$Timer.start()
	
func spawn_mob():
	if mob_count >= mob_cap:
		Global.wave += 1
		mob_cap *= 1.5
		return
	#if mob_count % 2 == 0:
	new_mob = preload("res://ZombieWeak.tscn").instance()
	#else:
	#new_mob = preload("res://TorchGoblin.tscn").instance()
	path_follow.unit_offset = randf()
	new_mob.global_position = path_follow.global_position
	mob_count += 1
	add_child(new_mob)

#Usar State Machine para o Player e os Mobs 

func _on_Timer_timeout():
	spawn_mob()


func _on_Player_health_is_over():
	gameover.visible = true
	get_tree().paused = true
