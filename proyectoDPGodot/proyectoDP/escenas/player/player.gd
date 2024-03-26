extends KinematicBody2D

const GRAVITY = 2250
const CAIDA = 800
#variables clase
var is_jump = false
var is_falling = false
##########################
var PLAYER_NAME = "Raymond"
var SPEED = 500
var VELOCITY = Vector2()
var VIDA_PLAYER = 10
var MONEDAS = 0
############
var DISPARO = preload("res://disparo.tscn")
var DISPAROIZQ = preload("res://disparoIzq.tscn")
############
var tiempoTranscurridoDisparo = 0
var tiempoPorCadaDisparo = 0.2
var booleanoDisparo = false 
var direccionDisparo = true #false es izquierda

onready var animatedSprite  = $AnimatedSprite

##FUNCIONAMIENTO DE RECOLECCION DE ITEMS Y RECIBIR ATAQUE ENEMIGO
func _on_Area2D_area_exited(area):
	if area.is_in_group("moneda") :
		print("MONEDA AGREGADA jujuuu:) ")
		
		VariablesGlobales.MONEDAS_GLOBAL = VariablesGlobales.MONEDAS_GLOBAL + 1
		print(VariablesGlobales.MONEDAS_GLOBAL)
	elif area.is_in_group("enemy") :
		#VIDA_PLAYER = VIDA_PLAYER - 1
		VariablesGlobales.VIDAS_GLOBAL = VariablesGlobales.VIDAS_GLOBAL - 1
		print("RAYMOND TIENE ESTA VIDA --- >>>> ", VIDA_PLAYER)
	elif area.is_in_group("enemymaster") :
		#VIDA_PLAYER = VIDA_PLAYER - 2
		VariablesGlobales.VIDAS_GLOBAL = VariablesGlobales.VIDAS_GLOBAL - 2
		print("RAYMOND TIENE ESTA VIDA --- >>>> ", VIDA_PLAYER)
	if VariablesGlobales.VIDAS_GLOBAL <= 0:
		queue_free()
		get_tree().change_scene("res://gameOver.tscn")

func _ready():
	pass
	
func _process(_delta):
	##Disparo 
	tiempoTranscurridoDisparo += _delta
	animation()
	
func _physics_process(_delta):
	
	
	move(_delta)
	
	move_and_slide(VELOCITY, Vector2(0,-1))


func move(_delta):
	
	VELOCITY.x = 0
	
#	if(!tocaSuelo():
#		velocity.y += gravity * _delta

	if(!is_on_floor()):
		VELOCITY.y += GRAVITY * _delta
		
	elif(is_on_floor()):
		#print("Esta tocando suelo")
		VELOCITY.y = 0
		is_jump = false
		
	if(Input.is_action_pressed("jump") and is_on_floor()):
		print("Esta brincando")
		VELOCITY.y = -1100
		print(VELOCITY.y)
		is_jump = true
		
	#Agregado en clase
	if Input.is_action_just_pressed("down"):
		VELOCITY.x = 0
		#if Input.is_action_pressed("jump") and !is_jump:
		set_collision_mask_bit(1,false)
			#velocity.y=gravity
		VELOCITY.y = CAIDA
	else:
		set_collision_mask_bit(1,true)
	###################

	if(Input.is_action_pressed("left")):
		#print("Tecla izquierda")
		direccionDisparo = false
		#print(direccionDisparo, "DIRECCION DE DISPARO DERECHA ")
		VELOCITY.x -= SPEED
		
	
	if(Input.is_action_pressed("right")):
		#print("Tecla derecha")
		direccionDisparo = true
		#print(direccionDisparo, "DIRECCION DE DISPARO DERECHA ")
		VELOCITY.x += SPEED
		
	if(Input.is_action_pressed("disparar") and direccionDisparo == true):
		booleanoDisparo = true
		print(booleanoDisparo,"disparo Raymond Derecha -------")
		$disparo.playing=true
		disparar()	
	
	elif(Input.is_action_pressed("disparar") and direccionDisparo == false):
		booleanoDisparo = true
		print(booleanoDisparo,"disparo Raymond Izquierda-------")
		$disparo.playing=true
		disparariz()
	else:
		booleanoDisparo = false
	
#	if (get_slide_collision(get_slide_count()-1) != null):
#		var obj_col = get_slide_collision(get_slide_count()-1).collider
#		if (obj_col.is_in_group("enemy")):
#			VIDA_PLAYER = VIDA_PLAYER -1
#			print("Vida del jugador >", VIDA_PLAYER)
	
func disparar():
	if tiempoTranscurridoDisparo >= tiempoPorCadaDisparo:
		tiempoTranscurridoDisparo = 0 
		
		var disparo = DISPARO.instance()
		disparo.position = position + Vector2 ( 70 , 0 )
		get_parent().add_child(disparo)
		
		print("DISPARANDO DERECHA")
		pass
		
func disparariz():
	if tiempoTranscurridoDisparo >= tiempoPorCadaDisparo:
		tiempoTranscurridoDisparo = 0 
		
		var disparo = DISPAROIZQ.instance()
		disparo.position = position + Vector2 ( -70 , 0 )
		get_parent().add_child(disparo)
		
		print("DISPARANDO IZ")
		pass
	
func animation():
	
	if(VELOCITY.x < 0 and is_on_floor() and booleanoDisparo == true):
		animatedSprite.animation = "runShoot"
		animatedSprite.flip_h = true

	elif(VELOCITY.x < 0 and is_on_floor()):
		
		animatedSprite.animation = "runR"
		animatedSprite.flip_h = true

	elif(VELOCITY.x > 0 and is_on_floor() and booleanoDisparo == true):

		animatedSprite.animation = "runShoot"
		animatedSprite.flip_h = false
		
	elif(VELOCITY.x > 0 and is_on_floor()):
		animatedSprite.animation = "runR"
		animatedSprite.flip_h = false
	
		
	elif(VELOCITY.x == 0 and VELOCITY.y == 0 and animatedSprite.flip_h == true and booleanoDisparo == true):
			
			animatedSprite.animation ="idleShoot"
			animatedSprite.flip_h = true
			
	elif(VELOCITY.x == 0 and VELOCITY.y == 0 and animatedSprite.flip_h == true):
			
			animatedSprite.animation ="idleR"
			animatedSprite.flip_h = true
	
	elif(VELOCITY.x == 0 and VELOCITY.y == 0 and animatedSprite.flip_h == false and booleanoDisparo == true):
			
			animatedSprite.animation ="idleShoot"
			animatedSprite.flip_h = false
	
	elif(VELOCITY.x == 0 and VELOCITY.y == 0 and animatedSprite.flip_h == false):
			
			
			animatedSprite.animation ="idleR"
			animatedSprite.flip_h = false
	
	elif(VELOCITY.y > 0 and animatedSprite.flip_h == false and booleanoDisparo == true) :
		animatedSprite.animation = "jumpShoot"
		animatedSprite.flip_h = false
	
	elif(VELOCITY.y > 0 and animatedSprite.flip_h == false):
		animatedSprite.animation = "jumpDown"
		animatedSprite.flip_h = false
	
	elif(VELOCITY.y > 0 and animatedSprite.flip_h == true and booleanoDisparo == true):
		animatedSprite.animation = "jumpShoot"
		animatedSprite.flip_h = true
	
	elif(VELOCITY.y > 0 and animatedSprite.flip_h == true):
		animatedSprite.animation = "jumpDown"
		animatedSprite.flip_h = true
	
	elif(VELOCITY.y < 0 and animatedSprite.flip_h == false and booleanoDisparo == true):
		animatedSprite.animation = "jumpShoot"
		animatedSprite.flip_h = false
	
	elif(VELOCITY.y < 0 and animatedSprite.flip_h == false):
		animatedSprite.animation = "jumpUp"
		animatedSprite.flip_h = false
	
	elif(VELOCITY.y < 0 and animatedSprite.flip_h == true and booleanoDisparo == true):
		animatedSprite.animation = "jumpShoot"
		animatedSprite.flip_h = true
	
	elif(VELOCITY.y < 0 and animatedSprite.flip_h == true):
		animatedSprite.animation = "jumpUp"
		animatedSprite.flip_h = true
		

######################################			
#func tocaSuelo():
#	var contador = 0
#	while(contador < raycasts.size()):
#		if(raycasts[contador].is_colliding()):
#			return true
#		contador += 1
#
#	return false 
#ES UNA PRUEBA QUE FUNCIONA CON RAYCAST QUE BORRE 




