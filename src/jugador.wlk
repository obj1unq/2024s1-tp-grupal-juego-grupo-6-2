import wollok.game.*
import niveles.*
import colores.*
import posiciones.*

object jugador {

	var property position = game.at(5,1)
	//const nivel = nivel1
	var property monedasAtrapadas = []
	var property estadoDeJugador = jugandoDerecha
	
	var vida = 100
	
	
	method vida(_vida){
		vida += _vida
	}

	method vida(){
		return vida
	}

	method estadoDeJugador(_estadoDeJugador) {
		estadoDeJugador = _estadoDeJugador
		estadoDeJugador.activar()
	}
	
	method congelarse(){
		
		self.estadoDeJugador(congelado)
		game.schedule(2000, {self.estadoDeJugador(jugandoDerecha)})
	}

	method image() {
		return "jugador-" + estadoDeJugador.toString() + ".png"
	}

	method ganar() {
		estadoDeJugador = ganador
		estadoDeJugador.activar()
	}

	method perder() {
		estadoDeJugador = perdedor
		estadoDeJugador.activar()
	}
	
	method moverIzquierda() {
		estadoDeJugador = jugandoIzquierda
		estadoDeJugador.activar()
		self.position(izquierda.siguiente(self.position()))
	}

	method moverDerecha() {
		estadoDeJugador = jugandoDerecha
		estadoDeJugador.activar()
		self.position(derecha.siguiente(self.position()))
	}
	method saltar() {
		estadoDeJugador = saltando
		estadoDeJugador.activar()
		self.position(arriba.siguiente(self.position()))
		game.schedule(500, {self.estadoDeJugador(jugandoDerecha)})
	}
	
	method esAtravesable(){
		return false
	}
	

	/*method atraparColor(color) {
		self.validarColor(color)
		coloresAtrapados.add(color)
		self.chequearResultado()
	}

	method validarColor(color) {
		if (not nivel1.coloresAAtrapar().contains(color.nombre())) {
			self.chequearResultado()
			coloresAtrapados.remove(coloresAtrapados.last()) // VALIDAR LAST, LISTA VACIA
			self.error("No puedo atrapar este color..")
		}
	}

	method chequearResultado() {
		if (coloresAtrapados.size() == 10) {
			self.ganar()
		} else if (coloresAtrapados.size() == 0) {
			self.perder()
		}
	}*/

}

// ESTADOS DEL JUGADOR
object jugandoDerecha {
	method puedeMover() = true
	method activar() {}
}

object jugandoIzquierda {
	method puedeMover() = true
	method activar() {}
}

object saltando {
	method puedeMover() = true
	method activar() {}
}

object ganador {

	method puedeMover() = false

	method activar() {
		game.say(jugador, "Gané!")
		game.schedule(5000, { game.stop()})
	}
}

object congelado {
	method puedeMover() = false
	
}

object perdedor {

	method puedeMover() = false

	method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(0500, { game.stop()})
	}

}

