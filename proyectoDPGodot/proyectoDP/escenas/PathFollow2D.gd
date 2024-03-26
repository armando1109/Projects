extends PathFollow2D
## declaramos la variable que recoge el componentre animation player con simbolo dolar
onready var animationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("movimientoDePlataforma")
pass 
