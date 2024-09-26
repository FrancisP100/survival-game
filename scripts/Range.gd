extends Area2D

var areas_in_range = []
var players_in_range : Array

func _physics_process(delta):
	areas_in_range = get_overlapping_areas()
	for player in areas_in_range:
		if player.is_in_group("Player"):
			if players_in_range.has(player):
				pass
			else:
				players_in_range.push_front(player)
			
