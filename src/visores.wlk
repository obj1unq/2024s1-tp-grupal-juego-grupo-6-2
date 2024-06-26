import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import ranking.*

class ElementoDeEncabezado {

	method position() {
		return game.at(self.posicionX(), game.height() - 1)
	}

	method posicionX()

}

class VisorDeAtributos inherits ElementoDeEncabezado {

	method text()

	method textColor() = paleta.naranja()

}

object iconoVida inherits ElementoDeEncabezado {

	const property image = "vida.png"

	override method posicionX() {
		return 0
	}

}

object visorVida inherits VisorDeAtributos {

	override method posicionX() {
		return 1
	}

	override method text() {
		return jugador.vida().toString()
	}

}

object visorMonedas inherits VisorDeAtributos {

	override method posicionX() {
		return 5
	}

	override method text() {
		return jugador.monedas().toString()
	}

}

object iconoMoneda inherits ElementoDeEncabezado {

	const property image = "moneda.png"

	override method posicionX() {
		return 4
	}

}

object visorDeTiempo inherits VisorDeAtributos {

	override method posicionX() {
		return 9
	}

	override method text() {
		return controladorDeNivel.nivel().tiempo().toString()
	}

}

object iconoReloj inherits ElementoDeEncabezado {

	const property image = "reloj.png"

	override method posicionX() {
		return 8
	}

}

object visorFinDeTiempo inherits VisorDeAtributos {

	override method posicionX() {
	}

	override method position() {
		return game.center()
	}

	override method text() {
		return "FIN DE TIEMPO!"
	}

	override method textColor() = paleta.negro()

}

object visorFinDeJuego inherits VisorDeAtributos {

	override method posicionX() {
	}

	override method position() {
		return game.center()
	}

	override method text() {
		return "FIN DE JUEGO!!!\nJUNTASTE " + jugador.monedas().toString() + " MONEDAS!!!"
	}

	override method textColor() = paleta.negro()

}

object visorDeNivel inherits VisorDeAtributos {

	override method posicionX() {
		return 14
	}

	override method text() {
		return "Nivel: " + controladorDeNivel.nivel().toString()
	}

}

object visorDeSeleccion {

	var property menuActual = null
	var property position = game.at(7, 5)
	const property image = "moneda.png"

	method irAPosicionInicial() {
		self.position(game.at(self.posicionPrimerBoton().x() - 1, self.posicionPrimerBoton().y()))
	}

	method posicionPrimerBoton() {
		return menuActual.botonesDelMenuActual().first().position()
	}

	method moverAbajo() {
		self.position(game.at(position.x(), (position.y() - 1).max(menuActual.limiteInferiorEjeY())))
	}

	method moverArriba() {
		self.position(game.at(position.x(), (position.y() + 1).min(menuActual.limiteSuperiorEjeY())))
	}

}

object visorDeRanking inherits VisorDeAtributos {

	override method posicionX() {
		return 17
	}

	override method text() {
		return "HIGH-SCORE: " + ranking.top().toString()
	}

}

object paleta {

	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
	const property blanco = "FAFAFA"
	const property negro = "000000"
	const property naranja = "FF8000"

}

