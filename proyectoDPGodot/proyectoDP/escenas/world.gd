extends Node2D

func _ready():
	$fondo.playing = true
	pass
	
func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://gameOver.tscn")
	#get_tree().reload_current_scene()

