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

	method activar() 

	method puedeMover()

	method direccion()

}

// ESTADOS DEL JUGADOR
object jugandoDerecha inherits EstadoJugador {

	override method puedeMover() = true

	override method direccion() {
		return derecha
	}

	override method activar() {
		jugador.position(self.direccion().siguiente((jugador.position() )))
	}

}

object jugandoIzquierda inherits EstadoJugador {

	override method puedeMover() = true

	override method direccion() {
		return izquierda
	}

	override method activar() {
		jugador.position(self.direccion().siguiente((jugador.position() )))
	}

}

object saltando inherits EstadoJugador {

	override method puedeMover() = true

	override method direccion() {
		return arriba
	}

	override method activar() {
		jugador.position(self.direccion().siguiente((jugador.position() )))
	}

}

object ganador inherits EstadoJugador {

	override method puedeMover() = false

	override method activar() {
		game.say(jugador, "Gané!")
		game.schedule(3000, { game.stop()})
	}

	override method direccion() {
	}

}

object congelado inherits EstadoJugador {

	override method puedeMover() = false

	override method direccion() {
		self.error("Este estado no tiene direccion")
	}

	override method activar() {
		game.schedule(5000, { jugador.cambiarEstado(jugandoDerecha)})
	}

}

object perdedor inherits EstadoJugador {

	override method puedeMover() = false

	override method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(3000, { game.stop()})
	}

	override method direccion() {
		self.error("Este estado no tiene direccion")
	}

}

