import Marcas.*
import Personas.*

class Carpa {
	var limiteDeGente
	var property tieneBandaDeMusicaTrad
	var property marcaDeCerveza
	var property listaDePersonas = []
	
	method cantDePersonas() = listaDePersonas.size()
	
	method cantDePersonasEsPar() = self.cantDePersonas().even()
	
	method corroborarIngreso(unaPersona) = 
	self.cantDePersonas() + 1 <= limiteDeGente && !unaPersona.estaEbria()
	
	method ingresarPersona(unaPersona) {listaDePersonas.add(unaPersona)}
	
	method servirJarraA(unaPersona, capacidadDeJarra) {
		if (self.estaEnLaCarpa(unaPersona))
		unaPersona.comprarJarra(new Jarra(marca=marcaDeCerveza, capacidad=capacidadDeJarra, carpaServida = self))
		else self.error("La persona no se encuentra en la carpa")
		}
		
	method estaEnLaCarpa(unaPersona) = listaDePersonas.contains(unaPersona)
	
	method cantDeEbriosEmpedernidos() = listaDePersonas.count({p=> p.ebrioEmpedernido()})
	
	method esHomogenea() = listaDePersonas.all({p => p.paisOrigen() == listaDePersonas.first().paisOrigen()})
	
	method asistentesNoServidos() = listaDePersonas.filter({p => p.carpasDondeFueronServidos().all({carpa => carpa != self})})
	
}	
