import wollok.game.*
import niveles.*
import objetos.*
import posiciones.*

object jugador {

	var property position = game.at(5, 1)
	// const nivel = nivel1
	var property valorMonedasAtrapadas = 0
	var property estadoDeJugador = jugandoDerecha
	var property vida = 3

	method puedeMover() {
		return estadoDeJugador.puedeMover()
	}
	
	method sumarMoneda(valorMoneda) {
		valorMonedasAtrapadas += valorMoneda
	}

	method sumarVida() {
		vida += 1
	}
	
	method restarVida(){
		vida = vida - 1
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

	method corroborarSiGana(){
		if (valorMonedasAtrapadas == 100){
			self.ganar()
		}
	}
	
	method corroborarSiPierde(){
		if (vida == 0){
			self.perder()
		}
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
		game.schedule(3000, { game.stop()})
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
		game.schedule(3000, { game.stop()})
	}

}

