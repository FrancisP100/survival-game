extends Area2D

class_name Guns

const BULLET = preload("res://Assets/Weapons/Projectiles/Bullet.tscn")

var damage : float = 10.0
var target_enemy

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		
func _shoot():
	var new_bullet = BULLET.instance()
	new_bullet.direction = Vector2.RIGHT.rotated(rotation)
	new_bullet.rotation = rotation
	new_bullet.damage = damage
	new_bullet.global_position = $WeaponPoint/AnimatedSprite/ShootingPoint.global_position   #.normalized()
	new_bullet.target = target_enemy
	get_parent().get_parent().add_child(new_bullet)

func _on_Timer_timeout():
	_shoot()
