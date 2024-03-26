extends Area2D



func _on_moneda_body_entered(body):
	if body.is_in_group("player"):
		print("CONFIRMADO TOMO UNA MONEDA")
		queue_free()
	pass 
