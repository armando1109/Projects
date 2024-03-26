extends Control

#func _ready() -> void:
#	$die.play()
func _ready():
	$die.play()
	pass 

func _on_again_pressed():
	VariablesGlobales.MONEDAS_GLOBAL = 0 
	VariablesGlobales.VIDAS_GLOBAL = 10
	get_tree().change_scene("res://escenas/world.tscn")


func _on_quit2_pressed():
	VariablesGlobales.MONEDAS_GLOBAL = 0 
	VariablesGlobales.VIDAS_GLOBAL = 10
	get_tree().quit()
