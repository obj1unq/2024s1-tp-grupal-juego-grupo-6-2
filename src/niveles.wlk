import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*

class VisorDeAtributos{
	method position()	
	method text()
}
object visorVida inherits VisorDeAtributos {
	override method position(){return game.at(0, game.height()- 1)}
		
	method text() {
		return "Vida: " + jugador.vida()
	}
}

object visorMonedas inherits VisorDeAtributos {
	override method position(){return game.at(0, game.height()- 2)}
		
	method text() {
		return "Monedas: " + jugador.monedas()
	}
}


object nivel1 {

	const gravedadJugador = 500
	const property objetosCreados = []
	const property factoriesDeObjetos = [ creadorDeMonedas, creadorDeHielos, creadorDeVidas, creadorDeMazas ]

	method fondo() {
		return "fondoNivel1.jpg"
	}
	
	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	method init() {
		game.title("Nivel 1")
		game.cellSize(60)
		game.width(20)
		game.height(10)
		game.boardGround(self.fondo()) // background
		game.addVisual(jugador)
		keyboard.right().onPressDo{ jugador.moverDerecha()}
		keyboard.left().onPressDo{ jugador.moverIzquierda()}
		keyboard.up().onPressDo{ jugador.saltar()}
		creadorDeBaldosas.crearBaldosas()
		game.onTick(gravedadJugador, "GRAVEDAD_JUGADOR", { gravedad.aplicarEfectoCaida(jugador)})
		game.onTick(1000, "CREAR OBJETOS", { factoriesDeObjetos.anyOne().nuevoObjeto()})
		game.onTick(1000, "GRAVEDAD", { objetosCreados.forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		game.onCollideDo(jugador, { objeto => objeto.colisionarCon(jugador)})
		
		game.addVisualIn(visorVida, visorVida.position())
		game.addVisualIn(visorMonedas, visorMonedas.position())
		game.start()
	}

}

