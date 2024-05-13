import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*

object nivel1 {

	const gravedadJugador = 500
	const property objetosCreados = []
	const property factoriesDeObjetos = [creadorDeMonedas, creadorDeHielos, creadorDeVidas, creadorDeMazas]
	
	method fondo() {
		return "fondoNivel1.jpg"
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
		keyboard.up().onPressDo{game.schedule(gravedadJugador, {gravedad.aplicarEfectoCaida(jugador)})}
		creadorDeBaldosa.crearBaldosas()
		game.onTick(1000, "CREAR OBJETOS", { factoriesDeObjetos.anyOne().nuevoObjeto()})
		game.onTick(1000, "GRAVEDAD", { objetosCreados.forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		
		game.onCollideDo(jugador, { objeto => objeto.colisionarCon(jugador) })
		
		game.start()
	}

}

