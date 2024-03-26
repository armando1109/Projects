extends Area2D
export var pixelesPorSegundo : int = 900
onready var animatedSprite  = $AnimatedSprite


func _ready():
	pass 
	
func _next_to_left_wall() -> bool:
	return $AnimatedSprite/rayDisparoIzq.is_colliding()

func _process(_delta):
	
	animatedSprite.animation = "volando"
	position.x = position.x - pixelesPorSegundo * _delta
	animatedSprite.flip_h = true
	if _next_to_left_wall():
		animatedSprite.animation = "impacto"
		print("PEGO LA BALAAA")
		queue_free()
	
	if (position.x < -5000):
		queue_free()
###

