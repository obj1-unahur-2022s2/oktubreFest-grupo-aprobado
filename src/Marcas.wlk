class Marca {
	var property contenidoDeLupulo
	const property paisFabricante
	
	method graduacion()
}

class Rubia inherits Marca {
	var graduacion
	
	override method graduacion() = graduacion
}

class Negra inherits Marca {
	
	override method graduacion() = (contenidoDeLupulo*2).min(graduacionMundial.graduacionCervezaNegra())
}

class Roja inherits Negra {
	
	override method graduacion() = super() * 1.25
} 

class Jarra {
	const property capacidad
	const property marca
	const property carpaServida
	
	method contenidoDeAlcohol() {return marca.graduacion()/100 * capacidad} 
}

object graduacionMundial {
	var property graduacionCervezaNegra = 5
}