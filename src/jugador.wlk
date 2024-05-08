import wollok.game.*
import niveles.*
import objetos.*
import posiciones.*

object jugador {

	var property position = game.at(5, 1)
	// const nivel = nivel1
	var property monedasAtrapadas = []
	var property estadoDeJugador = jugandoDerecha
	var vida = 100

	method puedeMover() {
		return estadoDeJugador.puedeMover()
	}

	method vida(_vida) {
		vida += _vida
	}

	method sumarVida() {
		vida += 100
	}

	method vida() {
		return vida
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

	method ganar() {
		estadoDeJugador = ganador
		estadoDeJugador.activar()
	}

	method perder() {
		estadoDeJugador = perdedor
		estadoDeJugador.activar()
	}

	method moverIzquierda() {
		self.validarQuePuedeMover(izquierda)
		estadoDeJugador = jugandoIzquierda
		estadoDeJugador.activar()
		self.position(izquierda.siguiente(self.position()))
	}

	method moverDerecha() {
		self.validarQuePuedeMover(derecha)
		estadoDeJugador = jugandoDerecha
		estadoDeJugador.activar()
		self.position(derecha.siguiente(self.position()))
	}

	method saltar() {
		self.validarQuePuedeMover(arriba)
		estadoDeJugador = saltando
		estadoDeJugador.activar()
		self.position(arriba.siguiente(self.position()))
		game.schedule(500, { self.estadoDeJugador(jugandoDerecha)})
	}

	method validarQuePuedeMover(hacia) {
		self.validarPuedeIr(hacia)
		self.validarEstadoJugador()
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

// ESTADOS DEL JUGADOR
object jugandoDerecha {

	method puedeMover() = true

	method activar() {
	}

}

object jugandoIzquierda {

	method puedeMover() = true

	method activar() {
	}

}

object saltando {

	method puedeMover() = true

	method activar() {
	}

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

	method activar() {
	}

}

object perdedor {

	method puedeMover() = false

	method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(5000, { game.stop()})
	}

}

