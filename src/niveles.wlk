import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*

class Nivel {

	method cumpleObjetivo (personaje)
	method descripcionDeObjetivos()

	method objetosCreados()

	method gravedadJugador()

	method factoriesDeObjetos()

	method fondo()

	method siguiente()

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
		game.addVisualIn(visorVida, visorVida.position())
		game.addVisualIn(visorMonedas, visorMonedas.position())
		game.addVisualIn(visorObjetivo, visorObjetivo.position())
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

	override method init() {
		super()
		game.title("Nivel 1")
		//jugador.nivel(objetivoNivel1)
		
	}

	override method siguiente() {
		return nivel2
	}
	
	override method cumpleObjetivo(personaje) {
		return personaje.monedas() >= 3
	}

	override method descripcionDeObjetivos() { //
		return "Reuní 10 monedas de Oro para pasar nivel"
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

	override method init() {
		super()
		game.title("Nivel 2")
		
	}

	override method siguiente() {
		return nivel3
	}
	
	override method cumpleObjetivo(personaje) {
		return personaje.monedas() >= 3
	}

	override method descripcionDeObjetivos() { //
		return "Reuní 10 monedas de Oro para pasar nivel"
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

	override method init() {
		super()
		game.title("Nivel 3")
		
	}

	override method siguiente() {
		game.stop()
	}
	
	override method cumpleObjetivo(personaje) {
		return personaje.monedas() >= 3
	}

	override method descripcionDeObjetivos() { //
		return "Reuní 10 monedas de Oro para pasar nivel"
	}

}

class ObjetivoNivel {

	method cumpleObjetivo(personaje)

	method descripcionDeObjetivos()

}

object objetivoNivel1 inherits ObjetivoNivel {

	override method cumpleObjetivo(personaje) {
		return personaje.monedas() >= 3
	}

	override method descripcionDeObjetivos() { //
		return "Reuní 10 monedas de Oro para pasar nivel"
	}

}

class VisorDeAtributos {

	method position()

	method text()

}

object visorVida inherits VisorDeAtributos {

	override method position() {
		return game.at(0, game.height() - 1)
	}

	override method text() {
		return "Vida: " + jugador.vida()
	}

}

object visorMonedas inherits VisorDeAtributos {

	override method position() {
		return game.at(2, game.height() - 1)
	}

	override method text() {
		return "Monedas: " + jugador.monedas()
	}

}

object visorObjetivo inherits VisorDeAtributos {

	override method position() {
		return game.at(6, game.height() - 1)
	}

	override method text() {
		return objetivoNivel1.descripcionDeObjetivos()
	}

}

