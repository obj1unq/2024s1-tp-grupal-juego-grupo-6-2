import wollok.game.*
import jugador.*
import colores.*
import posiciones.*

object nivel1 {

	const property coloresAAtrapar = #{ "negro", "rojo", "azul" }
	const gravedadJugador = 500
	const gravedadColor = 1000 
	const colores = creadorDeColores.coloresCreados()

	method fondo() {
		return "fondoNivel1.jpg"
	}

	method init() {
		game.title("Nivel 1")
		console.println("lvl1")
		game.cellSize(40)
		game.width(20)
		game.height(10)
		game.boardGround(self.fondo())
		game.addVisualCharacter(jugador)
		keyboard.right().onPressDo{ jugador.moverDerecha()}
		keyboard.left().onPressDo{ jugador.moverIzquierda()}
		game.onCollideDo(jugador, { algo => algo.colisionarCon(jugador)})
		game.onTick(3000, "COLORES", { creadorDeColores.crearColor()})
		game.onTick(gravedadColor, "GRAVEDAD", { colores.forEach{ color => gravedad.aplicarEfectoCaida(color)}})
		game.onTick(gravedadJugador, "GRAVEDADJUGADOR", { gravedad.aplicarEfectoCaida(jugador)})
		game.onTick(3000, "CREAR COLOR", { creadorDeColores.crearColor()})
		game.start()
	}

}

