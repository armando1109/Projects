extends Control

func _ready():
	$fondo.playing = true
	pass 
func _on_play_pressed():
	get_tree().change_scene("res://escenas/world.tscn")

func _on_quit2_pressed():
	VariablesGlobales.MONEDAS_GLOBAL = 0 
	VariablesGlobales.VIDAS_GLOBAL = 5
	get_tree().quit()
