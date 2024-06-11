import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*

class VisorDeAtributos {

	method position() {
		return game.at(self.posicionX(), game.height() - 1)
	}

	method posicionX() {
		return 0
	}

	method text()

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

//	override method posicionX() {
//		return 
//	}
	override method position() {
		return game.at(14, game.height() - 1)
	}

	override method text() {
		return "Nivel: " + controladorDeNivel.nivel().toString()
	}

}

class VisorMenuInicial inherits VisorDeAtributos {

	override method position() {
		return game.at(0, 0)
	}

	override method text() {
		return "Usa las flechas para moverte en el menu."
	}

}

class VisorInstruccionesMenuInicial inherits VisorDeAtributos {

	override method position() {
		return game.center()
	}

	override method text() {
		return "Para empezar el nivel seleccioná empezar y junta la mayor cantidad de monedas."
	}

}

class VisorInstruccionesMenuTransicion inherits VisorDeAtributos {

	override method position() {
		return game.center()
	}

	override method text() {
		return "Para comprar 1 vida por 10 monedas pulsa la tecla v."
	}

}

object visorDeSeleccion {

	var property position = game.at(3, 8)

	method moverAbajo() {
		self.position(game.at(position.x(), (position.y() - 1).max(5)))
	}

	method moverArriba() {
		self.position(game.at(position.x(), (position.y() + 1).min(8)))
	}

	method image() {
		return "moneda.png"
	}

}

