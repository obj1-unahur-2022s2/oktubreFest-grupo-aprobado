import Marcas.*
import Carpas.*

class Persona {
	const property peso
	var property jarrasQueCompro = []
	const property nivelDeAguante
	const property gustoPorMusicaTradicional
	const property paisOrigen
	
	method estaEbria() = self.totalDeAlcohol() * peso > nivelDeAguante
	
	method leGusta(unaMarca)
	
	method comprarJarra(unaJarra) = jarrasQueCompro.add(unaJarra)
	
	method totalDeAlcohol() = jarrasQueCompro.sum({j => j.contenidoDeAlcohol()})
	
	method quiereEntrarA(unaCarpa) = self.leGusta(unaCarpa.marcaDeCerveza()) &&
		gustoPorMusicaTradicional == unaCarpa.tieneBandaDeMusicaTrad()
		
	method puedeEntrarA(unaCarpa) = self.quiereEntrarA(unaCarpa) && unaCarpa.corroborarIngreso(self)
	
	method ingresarA(unaCarpa) { if (self.puedeEntrarA(unaCarpa)) unaCarpa.ingresarPersona(self) 
		else self.error("No puede ingresar a la carpa")}
		
	method todasMayoresA1Lt() = jarrasQueCompro.all({j=>j.capacidad() >= 1})
	
	method ebrioEmpedernido() = self.estaEbria() && self.todasMayoresA1Lt()
	
	method esPatriota() = jarrasQueCompro.all({j=>j.marca().paisFabricante() == paisOrigen})
	
	method carpasDondeFueronServidos() = jarrasQueCompro.map({j => j.carpaServida()})
	
	method estaEntrandoEnElVicio() {
		var estado = false
		if (jarrasQueCompro.size() > 1) {
			estado = self.seEstaEnviciando(jarrasQueCompro)
		}
		return estado
	}
	
	method seEstaEnviciando(listaJarras) {
		var vicio = true
		if (listaJarras.size() > 1) {
			if (listaJarras.first().capacidad() <= listaJarras.get(1).capacidad()) {
				vicio = self.seEstaEnviciando(listaJarras.subList(1, listaJarras.size()-1))
			}
			else {
				vicio = false
			}
		}
		return vicio
	}
	
	method sonCompatibles(persona) = self.coincidencias(persona).size() > self.diferencias(persona).size()
	method marcasCompradas() = jarrasQueCompro.map({j => j.marca()}).asSet()
	method coincidencias(persona) = self.marcasCompradas().intersection(persona.marcasCompradas())
	method diferencias(persona) = self.marcasCompradas().difference(persona.marcasCompradas())
}

class Belga inherits Persona {
	override method leGusta(unaMarca) = unaMarca.contenidoDeLupulo() > 4
}

class Checo inherits Persona {
	override method leGusta(unaMarca) = unaMarca.graduacion() > 8
}

class Aleman inherits Persona {
	override method leGusta(unaMarca) = true
	
	override method quiereEntrarA(unaCarpa) = super(unaCarpa) && unaCarpa.cantDePersonasEsPar()
}