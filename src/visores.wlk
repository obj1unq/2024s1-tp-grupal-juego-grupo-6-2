import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import ranking.*

class VisorDeAtributos {

	method position() {
		return game.at(self.posicionX(), game.height() - 1)
	}

	method posicionX() {
		return 0
	}

	method text()

	method textColor() = paleta.blanco()

}

object visorVida inherits VisorDeAtributos {

	override method text() {
		return "Vida: " + jugador.vida()
	}

}

object visorMonedas inherits VisorDeAtributos {

	override method posicionX() {
		return 2
	}

	override method text() {
		return "Monedas: " + jugador.monedas().toString()
	}

}

object visorDeTiempo inherits VisorDeAtributos {

	override method posicionX() {
		return 10
	}

	override method text() {
		return "Tiempo: " + controladorDeNivel.nivel().tiempo().toString()
	}

}

object visorFinDeTiempo inherits VisorDeAtributos {

	var property text = "Fin de tiempo!"

	override method position() {
		return game.center()
	}

	override method text() {
		return text
	}

}

object visorDeNivel inherits VisorDeAtributos {

	override method position() {
		return game.at(14, game.height() - 1)
	}

	override method text() {
		return "Nivel: " + controladorDeNivel.nivel().toString()
	}

}

object visorDeSeleccion {

	var property menuActual = null
	var property position = game.at(7, 5)

	method irAPosicionInicial() {
		self.position(game.at(self.posicionPrimerBoton().x()-1, self.posicionPrimerBoton().y()))
	}
	method posicionPrimerBoton(){
		return menuActual.botonesDelMenuActual().first().position()
	}
	method moverAbajo() {
		//self.position(game.at(position.x(), (position.y() - 1).max(2)))
		self.position(game.at(position.x(), (position.y() - 1).max(menuActual.limiteInferiorEjeY())))
	}

	method moverArriba() {
		self.position(game.at(position.x(), (position.y() + 1).min(menuActual.limiteSuperiorEjeY())))
	}

	method image() {
		return "moneda.png"
	}

}

object visorDeRanking inherits VisorDeAtributos {

	override method position() {
		return game.at(16, game.height() - 1)
	}

	override method text() {
		return "High-Score: " + ranking.top().toString()
	}

}

object paleta {

	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
	const property blanco = "FAFAFA"

}

