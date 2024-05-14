import wollok.game.*
import niveles.*
import objetos.*
import posiciones.*

object jugador {

	var property position = game.at(5, 1)
	// const nivel = nivel1
	var property monedas = 0
	var property estadoDeJugador = jugandoDerecha
	var property vida = 3

	method limiteInferior() = 1

	method puedeMover() {
		return estadoDeJugador.puedeMover()
	}

	method sumarMoneda(valorMoneda) {
		monedas += valorMoneda
		self.corroborarSiGana()
	}

	method sumarVida() {
		vida += 1
	}

	method restarVida() {
		vida = vida - 1
		self.corroborarSiPierde()
	}

	method estadoDeJugador(_estadoDeJugador) {
		estadoDeJugador = _estadoDeJugador
		estadoDeJugador.activar()
	}

	method congelarse() {
		self.estadoDeJugador(congelado)
		game.schedule(5000, { self.estadoDeJugador(jugandoDerecha)})
	}

	method image() {
		return "jugador-" + estadoDeJugador.toString() + ".png"
	}

	method corroborarSiGana() {
		if (monedas == 50) {
			self.ganar()
		}
	}

	method corroborarSiPierde() {
		if (vida == 0) {
			self.perder()
		}
	}

	method ganar() {
		self.estadoDeJugador(ganador)
	}

	method perder() {
		self.estadoDeJugador(perdedor)
	}

	method moverIzquierda() {
		self.estadoDeJugador(jugandoIzquierda)
		self.estadoDeJugador().mover()
	}

	method moverDerecha() {
		self.estadoDeJugador(jugandoDerecha)
		self.estadoDeJugador().mover()
	}

	method saltar() {
		self.estadoDeJugador(saltando)
		self.estadoDeJugador().mover()
	}

	method validarQuePuedeMover(hacia) {
		self.validarEstadoJugador()
		self.validarPuedeIr(hacia)
	}

	method validarEstadoJugador() {
		if (not self.estadoDeJugador().puedeMover()) {
			self.error("No me puedo mover :/")
		}
	}

	method validarPuedeIr(hacia) {
		if (not self.puedeIr(hacia)) {
			self.error("No puedo ir en esa direccion")
		}
	}

	method puedeIr(hacia) {
		return tablero.puedeMover(hacia, self)
	}

	method esAtravesable() {
		return false
	}

}

class EstadoJugador {
	
	method direccion(){return null}
	
	method puedeMover() = true

	method mover(){
		jugador.validarQuePuedeMover(self.direccion())
		jugador.estadoDeJugador(self)
		jugador.position(self.direccion().siguiente(jugador.position()))
	}

	method activar(){}

}

// ESTADOS DEL JUGADOR

object jugandoDerecha inherits EstadoJugador {
	override method direccion(){return derecha}
	
}

object jugandoIzquierda inherits EstadoJugador {
	override method direccion(){return izquierda}
	
}

object saltando inherits EstadoJugador {
	override method direccion(){return arriba}
	
}

object ganador inherits EstadoJugador {

	override method puedeMover() = false

	override method activar() {
		game.say(jugador, "Gané!")
		game.schedule(3000, { game.stop()})
	}

}

object congelado inherits EstadoJugador {

	override method puedeMover() = false

}

object perdedor inherits EstadoJugador {

	override method puedeMover() = false

	override method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(3000, { game.stop()})
	}

}

