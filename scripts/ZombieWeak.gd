extends Mobs #Classe Mob

func _ready():
	health = 30.0
	$Health.max_value = health
	speed = 100
	damage = 10
