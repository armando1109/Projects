extends KinematicBody2D

#Dos constantes
const MAX_SPEDD : float = 100.0
const GRAVITY : float = 25.00
##Jugador
var VIDA_ENEMY = 5
var movimiento : = Vector2() #decide en que direccion se mueve el personaje
var temp = 0
var temp2 = temp2
var object
####
onready var animatedSprite  = $AnimatedSprite
#### Corresponde al funcionamiento del disparo ----------
var DISPARO = preload("res://disparoEnemy.tscn")
var DISPAROIZQ = preload("res://disparoIzqEnemy.tscn")


var tiempoTranscurridoDisparo = 0
var tiempoPorCadaDisparo = 0.5
var booleanoDisparo = true 
var direccionDisparo = true #false es izquierda
var NUMEROBALAS = 0
var CONTADOR = 0

# ----------------------------------------------------

func _ready():
	#AnimatedSprite.scale.x = 0.519 ##con esto decidimos en que direccion inicia
	movimiento.x = MAX_SPEDD ##con esto inicia andando
	#$AnimatedSprite/RayAtack.add_exception()
	pass  
#############################################
func _next_to_left_wall() -> bool:
	return $leftRay.is_colliding()
	
func _next_to_right_wall() -> bool:
	return $rightRay.is_colliding()
	
func _floor_detection() -> bool:
	return $AnimatedSprite/floorDetection.is_colliding()
################################################
func _next_to_wall_atack() -> bool:
	#$AnimatedSprite/RayAtack.add_exception(TileSet)
	return $AnimatedSprite/RayAtack.is_colliding()
	
	# is_collide_with_areas_enabled()
func _next_to_wall_atack2() -> bool:
	return $AnimatedSprite/RayAtack2.is_colliding()

func detectar_enemigo():
	$AnimatedSprite/RayAtack.get_collider()
	print("VEAMOS CON QUE COLISIONA EL RAY ENEMIGO ---",$AnimatedSprite/RayAtack.get_collider())
	if $AnimatedSprite/RayAtack.get_collider() == KinematicBody2D:
		print("DETECTO AL ENEMIGO ---",$AnimatedSprite/RayAtack.get_collider())
		return true
	else:
		return false
#################################################
func _on_Area2D_area_entered(area):
	VIDA_ENEMY = VIDA_ENEMY - 1
	print("TIENE ESTA VIDA --- >>>> ", VIDA_ENEMY)
	if VIDA_ENEMY == 0:
		queue_free()
	pass
####################################################

func _flip():###El bucle que hace que el enemigo se mueva solo 
#	if  !_next_to_wall_atack() :
	if _next_to_wall_atack() == true and movimiento.x > 0 :
		print("ENEMIGO RAYCAST COLISIONO CON >>>", $AnimatedSprite/RayAtack.get_collider())
		NUMEROBALAS = 10
		CONTADOR = 0
		print(">>>>>>>>> DETECTO ALGO ")
		movimiento.x = 0 
		animatedSprite.animation = "atacking"
		$fuego.playing=true
		disparar()
		print("ENEMIGO ATACA A LA DERECHA ------ >")
		#$AnimatedSprite/RayAtack.force_raycast_update()
#		$AnimatedSprite/RayAtack.set_enabled(false)
#		$AnimatedSprite/RayAtack.set_enabled(true)
		
		
	if  _next_to_wall_atack() == true and movimiento.x < 0 :
		print("ENEMIGO RAYCAST COLISIONO CON >>>", $AnimatedSprite/RayAtack.get_collider())
		NUMEROBALAS = 10
		CONTADOR = 0
		print("Aqui el boleanoooo ",_next_to_wall_atack())
		print(">>>>>>>>> DETECTO ALGO ")
		movimiento.x = 0 
		animatedSprite.animation = "atacking"
		$fuego.playing=true
		disparariz()
		print("ENEMIGO ATACA A LA IZQUIERDA ------ >")
		#$AnimatedSprite/RayAtack.force_raycast_update()
		##AQUI ABAJO EL SEGUNDO ATAQUE
#		$AnimatedSprite/RayAtack.set_enabled(false)
#		$AnimatedSprite/RayAtack.set_enabled(true)
	if !_next_to_wall_atack():
		if _next_to_right_wall() or _next_to_left_wall() or !_floor_detection():
			animatedSprite.animation = "running"
			#movimiento.x *= -1
			movimiento.x = movimiento.x * -1
			temp = movimiento.x
			$AnimatedSprite.scale.x *= -1
			#print("Esta atacando?......",_next_to_wall_atack())
	
	if movimiento.x == 0 and _next_to_wall_atack() == false:
		animatedSprite.animation = "running"
		movimiento.x = temp
		
	
		
		
func disparar():
	if tiempoTranscurridoDisparo >= tiempoPorCadaDisparo:
		tiempoTranscurridoDisparo = 0 
		
		var disparo = DISPARO.instance()
		disparo.position = position + Vector2 ( 88 , 0 )
		get_parent().add_child(disparo)
		print("DISPARANDO DERECHA")
		pass
		
func disparariz():
	
	if tiempoTranscurridoDisparo >= tiempoPorCadaDisparo:
		tiempoTranscurridoDisparo = 0 

		var disparo = DISPAROIZQ.instance()
		disparo.position = position + Vector2 ( -88 , 0 )
		get_parent().add_child(disparo)
		print("------------- ENEMIGO DISPARA A LA IZQUIERDA")
		pass
		
func _process(_delta):
	movimiento.y += GRAVITY
	tiempoTranscurridoDisparo += _delta

	movimiento = move_and_slide(movimiento)
	
	_flip()
	
	if (get_slide_collision(get_slide_count()-1) != null):
		var obj_col = get_slide_collision(get_slide_count()-1).collider
		CONTADOR = (get_slide_count()-1)
		#print ("COLLISIONES SIN PLAYER >>> ----", obj_col, CONTADOR)
		if (obj_col.is_in_group("player")):
			#print ("COLLISIONES PLAYER >>> ----", obj_col, CONTADOR)
			#print("CHOCOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
			queue_free()
	pass

