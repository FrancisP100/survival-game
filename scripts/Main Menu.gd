extends Control

onready var tween = $Tween
onready var player = $VBoxContainer/Start_Button/HBoxContainer/AnimatedSprite
onready var zombie = $VBoxContainer/Start_Button/HBoxContainer/AnimatedSprite2


func _on_Start_Button_mouse_entered():
	tween.interpolate_property(player, "self_modulate", player.self_modulate , Color(1,1,1,1), 1, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.interpolate_property(zombie, "self_modulate", zombie.self_modulate , Color(1,1,1,1), .7, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

func _on_Start_Button_mouse_exited():
	tween.interpolate_property(player, "self_modulate", player.self_modulate , Color(1,1,1,0), 2.3, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.interpolate_property(zombie, "self_modulate", zombie.self_modulate , Color(1,1,1,0), 2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

func _on_Start_Button_focus_entered():
	pass

func _on_Start_Button_focus_exited():
	pass

func _on_Start_Button_button_up():
	get_tree().change_scene("res://Game.tscn")

func _on_Exit_Button_button_up():
	get_tree().quit()
