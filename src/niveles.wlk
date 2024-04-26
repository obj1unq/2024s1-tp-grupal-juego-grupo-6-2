import wollok.game.*
import jugador.*
import colores.*
import posiciones.*


object nivel1 {
	
	const property coloresAAtrapar = #{"negro", "rojo", "azul"}
	const gravedad = 3000
	const colores = creadorDeColores.coloresCreados()

	method fondo(){
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
		keyboard.right().onPressDo{jugador.moverDerecha()}
		keyboard.left().onPressDo{jugador.moverIzquierda()}
		
		game.onTick(3000, "COLORES", {creadorDeColores.crearColor() })
	
		
		game.onTick(gravedad, "GRAVEDAD", {colores.forEach {color => color.caer()} })
		
		game.onTick(3000, "CREAR COLOR", { creadorDeColores.crearColor()})
		game.start()
	}
}