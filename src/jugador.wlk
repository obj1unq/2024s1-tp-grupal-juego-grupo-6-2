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
	var property nivel = null

	method limiteInferior() = 1

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

	method congelarse() {
		self.cambiarEstado(congelado)
	}

	method image() {
		return "jugador-" + estadoDeJugador.toString() + ".png"
	}

	method corroborarSiGana() {
		if (nivel.cumpleObjetivo(self)) {
			self.ganar()
		}
	}

	method corroborarSiPierde() {
		if (vida == 0) {
			self.perder()
		}
	}

	method ganar() {
		self.cambiarEstado(ganador)
	}

	method perder() {
		self.cambiarEstado(perdedor)
	}

	method mover(_estadoDeJugador) {
		if (self.puedeMover(_estadoDeJugador)) {
			self.cambiarEstado(_estadoDeJugador)
		}
	}

	method puedeCaer() {
		return self.puedeMover(estadoDeJugador)
	}

	method puedeMover(estadoJugador) {
		return estadoDeJugador.puedeMover() && tablero.puedeIr(self, estadoJugador.direccion())
	}

	method cambiarEstado(_estadoDeJugador) {
		estadoDeJugador = _estadoDeJugador
		estadoDeJugador.activar()
	}

	method esAtravesable() {
		return false
	}

}

class EstadoJugador {

	method puedeMover()

	method activar()

}

class EstadoJugadorMovible inherits EstadoJugador {

	override method puedeMover() = true

	override method activar() {
		jugador.position(self.direccion().siguiente((jugador.position() )))
	}

	method direccion()

}

class EstadoJugadorInmovible inherits EstadoJugador {

	override method puedeMover() = false

}

// ESTADOS DEL JUGADOR
object jugandoDerecha inherits EstadoJugadorMovible {

	override method direccion() {
		return derecha
	}

}

object jugandoIzquierda inherits EstadoJugadorMovible {

	override method direccion() {
		return izquierda
	}

}

object saltando inherits EstadoJugadorMovible {

	override method direccion() {
		return arriba
	}

}

object ganador inherits EstadoJugadorInmovible {

	override method activar() {
		game.say(jugador, "Gané!")
		game.schedule(3000, { game.stop()})
	}

}

object congelado inherits EstadoJugadorInmovible {

	override method activar() {
		game.say(jugador, "Estoy congelado")
		game.schedule(5000, { jugador.cambiarEstado(jugandoDerecha)})
	}

}

object perdedor inherits EstadoJugadorInmovible {

	override method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(3000, { game.stop()})
	}

}

