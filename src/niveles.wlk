import ranking.* 
import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*
import visores.*

class Nivel {

	const tiempoDeJuego = 10

	method descripcionDeObjetivos() {
		return "Reuní la mayor cantidad de monedas antes de que finalice el tiempo"
	}

	method objetosCreados()

	method gravedadJugador()

	method factoriesDeObjetos()

	method fondo()

	method siguiente()

	method tiempoDeJuego() {
		return 20
	}

	method init() {
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.boardGround(self.fondo()) // background
		game.addVisual(jugador)
		game.onCollideDo(jugador, { objeto => objeto.colisionarCon(jugador)})
		keyboard.right().onPressDo{ jugador.mover(jugandoDerecha)}
		keyboard.left().onPressDo{ jugador.mover(jugandoIzquierda)}
		keyboard.up().onPressDo{ jugador.mover(saltando)}
		creadorDeBaldosas.crearBaldosas()
		game.onTick(self.gravedadJugador(), "GRAVEDAD_JUGADOR", { gravedad.aplicarEfectoCaida(jugador)})
		game.onTick(600, "CREAR OBJETOS", { self.factoriesDeObjetos().anyOne().nuevoObjeto()})
		game.onTick(300, "GRAVEDAD", { self.objetosCreados().forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		game.onTick(1000, "CRONOMETRO", { visorDeTiempo.descontar(1)})
		game.addVisualIn(visorVida, visorVida.position())
		game.addVisualIn(visorMonedas, visorMonedas.position())
		game.addVisualIn(visorObjetivo, visorObjetivo.position())
		visorDeTiempo.tiempo(tiempoDeJuego)
		game.addVisualIn(visorDeTiempo, visorDeTiempo.position())
		game.addVisualIn(visorDeNivel, visorDeNivel.position())
		game.addVisualIn(visorDeRanking, visorDeRanking.position())
	}

}

object nivel {

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

	override method factoriesDeObjetos() {
		return [ creadorDeMonedas, creadorDeHielos, creadorDeVidas, creadorDeMazas ]
	}

	override method gravedadJugador() {
		return 1000
	}

	override method fondo() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

//	override method init() {
//		super()
//		game.title("Nivel 1")
//	}

	override method siguiente() {
		return nivel2
	}

}

object nivel2 inherits Nivel {

	const property objetosCreados = []

	override method factoriesDeObjetos() {
		return [ creadorDeMonedas, creadorDeHielos, creadorDeVidas, creadorDeMazas ]
	}

	override method gravedadJugador() {
		return 1000
	}

	override method fondo() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

//	override method init() {
//		super()
//		game.title("Nivel 2")
//	}

	override method siguiente() {
		return nivel3
	}

}

object nivel3 inherits Nivel {

	const property objetosCreados = []

	override method factoriesDeObjetos() {
		return [ creadorDeMonedas, creadorDeHielos, creadorDeVidas, creadorDeMazas ]
	}

	override method gravedadJugador() {
		return 1000
	}

	override method fondo() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

//	override method init() {
//		super()
//		game.title("Nivel 3")
//	}

	override method siguiente() {
		ranking.guardar(jugador.monedas())
		jugador.reiniciar()
		return nivel1
		
	}

}

