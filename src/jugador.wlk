import wollok.game.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*

object jugador {

	var property position = game.at(5, 1)
	var property monedas = 0
	var property estadoActual = jugandoDerecha
	var property vida = 3
	var property potenciadorMonedas = 1
	var property potenciadorTiempo = 1
	
	method limiteInferior() = 1

	method sumarMoneda(valorMoneda) {
		monedas += valorMoneda*potenciadorMonedas
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
		return "jugador-" + estadoActual.imagenEstado() + ".png"
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

	method mover(estadoProximo) {
		if (self.puedeMover(estadoProximo)) {
			self.cambiarEstado(estadoProximo)
		}
	}

	method puedeCaer() {
		return self.puedeMover(estadoActual)
	}

	method puedeMover(estadoProximo) {
		return estadoActual.puedeMover() && tablero.puedeIr(self, estadoProximo.direccion()) && not tablero.hayObstaculo(estadoProximo.siguienteDireccion())
	}

	method cambiarEstado(_estadoDeJugador) {
		estadoActual = _estadoDeJugador
		estadoActual.activar()
	}

	method esAtravesable() {
		return false
	}

	method accionAlColisionarCon(objeto) {
	}

	method reiniciar() {
		monedas = 0
	}

}

class EstadoJugador {

	method puedeMover() = false

	method activar()

	method imagenEstado() {
		return self
	}

}

class EstadosDeMovimiento inherits EstadoJugador {

	const property direccion

	method siguienteDireccion(){
		return self.direccion().siguiente((jugador.position() ))
	}
	
	override method puedeMover() = true

	override method activar() {
		jugador.position(self.direccion().siguiente((jugador.position() )))
	}

}

// ESTADOS DEL JUGADOR MOVIMIENTO
object jugandoDerecha inherits EstadosDeMovimiento(direccion = derecha) {

}

object jugandoIzquierda inherits EstadosDeMovimiento (direccion = izquierda) {

}

object saltando inherits EstadosDeMovimiento(direccion = arriba) {

	var estadoImagen = self

	override method activar() {
		if (self.puedeSaltar()) {
			estadoImagen = self
			super()
			game.schedule(300, { self.aterrizar()})
		}
	}

	method puedeSaltar() {
		return jugador.position().y() == 1
	}

	method aterrizar() {
		estadoImagen = jugandoDerecha
	}

	override method imagenEstado() {
		return estadoImagen
	}

}

object agachando inherits EstadosDeMovimiento(direccion = abajo) {

}

// ESTADOS DEL JUGADOR JUGABILIDAD
object ganador inherits EstadoJugador {

	override method activar() {
		game.say(jugador, "Gané!")
		jugador.cambiarEstado(jugandoDerecha)
		controladorDeNivel.pasarNivel()
		game.clear()
		game.schedule(3000, { controladorDeNivel.nivel().init()})
	}

}

object congelado inherits EstadoJugador {

	override method activar() {
		game.say(jugador, "Estoy congelado")
		game.schedule(5000, { jugador.cambiarEstado(jugandoDerecha)})
	}

}

object perdedor inherits EstadoJugador {

	override method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(3000, { game.stop()})
	}

}

