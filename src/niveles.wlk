import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*


class Nivel {
	method objetosCreados()
	method gravedadJugador()
	method factoriesDeObjetos()
	method fondo()
	
	method init(){
		game.cellSize(60)
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
		game.onTick(1000, "CREAR OBJETOS", { self.factoriesDeObjetos().anyOne().nuevoObjeto()})
		game.onTick(1000, "GRAVEDAD", { self.objetosCreados().forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		game.addVisualIn(visorVida, visorVida.position())
		game.addVisualIn(visorMonedas, visorMonedas.position())
	}		
}


object nivel1 inherits Nivel {

	const property objetosCreados = []
		
	override method factoriesDeObjetos(){
		return [ creadorDeMonedas, creadorDeHielos, creadorDeVidas, creadorDeMazas ]
	} 

	override method gravedadJugador(){
		return 500
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
		jugador.nivel(objetivoNivel1)
		game.start() 
	}

}

object objetivoNivel1 {
	method cumpleObjetivo(personaje) {
		return personaje.monedas() >= 50
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

	method text() {
		return "Vida: " + jugador.vida()
	}

}

object visorMonedas inherits VisorDeAtributos {

	override method position() {
		return game.at(0, game.height() - 2)
	}

	method text() {
		return "Monedas: " + jugador.monedas()
	}

}


