extends Area2D
export var pixelesPorSegundo : int = 500
onready var animatedSprite  = $AnimatedSprite
var status = false

func _ready():
	pass 

func _next_to_right_wall() -> bool:
	return $AnimatedSprite/rayDisparoDere.is_colliding()

func _process(_delta):
	
	animatedSprite.animation = "volando"
	position.x += pixelesPorSegundo * _delta
	
	if _next_to_right_wall():
		animatedSprite.animation = "impacto"
		print("PEGO LA BALAAA")
		queue_free()
		
	if (position.x > 20000):
		queue_free()
