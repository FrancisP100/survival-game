extends Camera2D

onready var player = get_node("../Player")
onready var tween = $Tween

func _physics_process(_delta):
	tween.interpolate_property(self, "global_position", self.global_position,
	player.global_position, 0.7,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
