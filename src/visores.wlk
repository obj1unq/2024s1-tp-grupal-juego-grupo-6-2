import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*


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
		return "Monedas: " + jugador.monedas().toString()
	}

}

object visorObjetivo inherits VisorDeAtributos {

	override method position() {
		return game.at(6, game.height() - 1)
	}

	override method text() {
		return nivel.nivel().descripcionDeObjetivos()
	}

}

object visorDeTiempo inherits VisorDeAtributos {

	var property tiempo = 20

	override method position() {
		return game.at(10, game.height() - 1)
	}

	override method text() {
		return "Tiempo: " + tiempo.toString()
	}

	method descontar(segundos) {
		tiempo -= segundos
		self.chequearFinDeTiempo()
	}

	method chequearFinDeTiempo() {
		if (tiempo == 0) self.pasarDeNivel()
	}

	method pasarDeNivel() {
		game.clear()
		game.addVisualIn(visorCentral, visorCentral.position())
		nivel.pasarNivel()
		game.schedule(3000, { game.clear()
			nivel.nivel().init()
		})
	}

}

object visorCentral inherits VisorDeAtributos {
	var property text = "Fin de tiempo!. Siguiente nivel mas complejo"
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
		return "Nivel: " + nivel.nivel().toString()
	}

}

object visorMenuInicial inherits VisorDeAtributos {
	var property text = "Usa las flechas para moverte en el menu."
	
	override method position() {return game.at(0,0)}

	override method text() {return text}

}

object visorInstruccionesMenuInicial inherits VisorDeAtributos {
	var property text = "Para empezar el nivel seleccioná empezar y junta la mayor cantidad de monedas."
	
	override method position() {return game.center()}

	override method text() {return text}

}

object visorInstruccionesMenuTransicion inherits VisorDeAtributos {
	var property text = "Para comprar 1 vida por 10 monedas pulsa la tecla v."
	
	override method position() {return game.center()}

	override method text() {return text}

}


