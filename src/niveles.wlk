import ranking.*
import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*
import menu.*

class Nivel {

	var property tiempo = self.tiempoDeJuego()
	const property position = game.at(0, 0)

	method descontarTiempo() {
		return if (self.tieneTiempo()) {
			tiempo -= self.segundosADescontar()
		} else {
			self.pasarDeNivel()
		}
	}

	method tieneTiempo() {
		return tiempo > 0
	}

	method tiempoDeJuego() {
		return 10
	}

	method segundosADescontar() {
		return 1
	}

	method descripcionDeObjetivos() {
		return "Reuní la mayor cantidad de monedas antes de que finalice el tiempo"
	}

	method objetosCreados()

	method gravedadJugador()

	method factoriesDeObjetos() {
		return [ new CreadorDeMonedas(nivel=self), new CreadorDeHielos(nivel=self), new CreadorDeVidas(nivel=self), new CreadorDeMazas(nivel=self) ]
	}

	method image()

	method siguiente()

	method nivel() {
		return self
	}

	method pasarDeNivel() {
		if (not self.tieneTiempo()) {
			game.clear()
			game.addVisual(visorFinDeTiempo)
			visorFinDeTiempo.text()
			controladorDeNivel.pasarNivel()
			game.schedule(1000, { menuTransicion.init()})
		}
	}

	method init() {
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.addVisual(self)
		game.addVisual(jugador)
		game.onCollideDo(jugador, { objeto => objeto.colisionarCon(jugador)})
		keyboard.right().onPressDo{ jugador.mover(jugandoDerecha)}
		keyboard.left().onPressDo{ jugador.mover(jugandoIzquierda)}
		keyboard.up().onPressDo{ jugador.mover(saltando)}
		creadorDeBaldosas.crearBaldosas()
		game.onTick(self.gravedadJugador(), "GRAVEDAD_JUGADOR", { gravedad.aplicarEfectoCaida(jugador)})
		game.onTick(600, "CREAR OBJETOS", { self.factoriesDeObjetos().anyOne().nuevoObjeto()})
		game.onTick(300, "GRAVEDAD", { self.objetosCreados().forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		game.onTick(1000, "CRONOMETRO", { self.descontarTiempo()})
		game.addVisual(visorVida)
		game.addVisual(visorMonedas)
		game.addVisual(visorDeTiempo)
		game.addVisual(visorDeNivel)
		game.addVisual(visorDeRanking)
	}

	method desaparecer() {
	}

}

object controladorDeNivel {

	var nivel = nivel1

	method pasarNivel() {
		nivel = nivel.siguiente()
	}

	method nivel() {
		return nivel
	}

}

object nivel1 inherits Nivel {

	const property objetosCreados = []

	override method gravedadJugador() {
		return 1000
	}

	override method image() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	override method siguiente() {
		return nivel2
	}

}

object nivel2 inherits Nivel {

	const property objetosCreados = []

	override method gravedadJugador() {
		return 1000
	}

	override method tiempoDeJuego() {
		return 5
	}

	override method image() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	override method siguiente() {
		return nivel3
	}

}

object nivel3 inherits Nivel {

	const property objetosCreados = []

	override method gravedadJugador() {
		return 1000
	}

	override method tiempoDeJuego() {
		return 10
	}

	override method image() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	override method siguiente() {
		ranking.guardar(jugador.monedas())
		jugador.reiniciar()
		return nivel1
	}

}

