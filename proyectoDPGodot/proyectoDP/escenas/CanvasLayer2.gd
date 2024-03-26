extends CanvasLayer

func _process(delta):
	$coinsText.text = " " + str(VariablesGlobales.MONEDAS_GLOBAL)
	$phText2.text = " " + str(VariablesGlobales.VIDAS_GLOBAL)

