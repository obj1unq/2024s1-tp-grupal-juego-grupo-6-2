import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*


class VisorDeAtributos {
	
	method position(){
		return game.at(self.posicionX(), game.height() - 1)
	}
	method posicionX(){return 0}
	
	method text()

}

class VisorVida inherits VisorDeAtributos {

	override method text() {
		return "Vida: " + jugador.vida()
	}

}

class VisorMonedas inherits VisorDeAtributos {

	override method posicionX() {
		return 2
	}

	override method text() {
		return "Monedas: " + jugador.monedas().toString()
	}

}

class VisorDeTiempo inherits VisorDeAtributos {

	var property tiempo = 20

	override method posicionX(){
		return 10
	}

	override method text() {
		return "Tiempo: " + tiempo.toString()
	}

	method descontar(segundos) {
		if(self.tieneTiempo())
		tiempo -= segundos
		
	}

	method tieneTiempo() {
		return tiempo > 0
	}
}	

class VisorFinDeTiempo inherits VisorDeAtributos {
	var property text = "Fin de tiempo!"
	override method position() {
		return game.center()
	}


	override method text() {
		return text
	}

}

class VisorDeNivel inherits VisorDeAtributos {
	const property nivel 
	override method posicionX() {
		return game.at(14, game.height() - 1)
	}

	override method text() {
		return "Nivel: " + nivel.toString()
	}

}

class VisorMenuInicial inherits VisorDeAtributos {
	
	override method position() {return game.at(0,0)}

	override method text() {return "Usa las flechas para moverte en el menu."}

}

class VisorInstruccionesMenuInicial inherits VisorDeAtributos {

	override method position() {return game.center()}

	override method text() {return "Para empezar el nivel seleccioná empezar y junta la mayor cantidad de monedas."}

}

class VisorInstruccionesMenuTransicion inherits VisorDeAtributos {

	
	override method position() {return game.center()}

	override method text() {return "Para comprar 1 vida por 10 monedas pulsa la tecla v."}

}

object visorDeSeleccion {
	var property position = game.at(self.ejeX(), self.ejeY())
	
	method moverAbajo() {return self.ejeY()+2.max(9)}
	
	method moverArriba() {return self.ejeY()-2.max(3)}
	
	method ejeX(){return 3}
	
	method ejeY(){return 3}
	
	method image() {return "moneda.png"}
}



