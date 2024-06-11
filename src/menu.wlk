import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*


class Menu {
	const objetosMenu =[new BotonEmpezar(), new BotonInstrucciones(), new BotonSalir()]
	var posicionBoton = 0
	const property position = game.at(0,0)
			
	method instrucciones(){
		return self.tipoDeInstrucciones().text()
	}
	
	method tipoDeInstrucciones(){
		return new VisorInstruccionesMenuTransicion()	
	}
	
	method salir(){
		game.stop()
	}
	
	method image(){return "fondoMenu.png"}
	
	method init(){
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.addVisual(self)
		game.addVisual(objetosMenu.get(0))
		game.addVisual(objetosMenu.get(1))
		game.addVisual(objetosMenu.get(2))
		game.addVisual(visorDeSeleccion)
		
		
		keyboard.down().onPressDo{
			posicionBoton = posicionBoton + 1
			visorDeSeleccion.moverAbajo()
		}
		
		keyboard.enter().onPressDo{ 
			objetosMenu.get(posicionBoton).activar()
			
		}
		
		keyboard.up().onPressDo{ 
			posicionBoton = posicionBoton - 1
			visorDeSeleccion.moverArriba()
		}
	}
}	


object menuInicial inherits Menu {
	
	override method tipoDeInstrucciones(){
		return new VisorInstruccionesMenuInicial()
	}
}

object menuTransicion inherits Menu {
	
	method canjearMonedas(){}
	
		
}

class Boton {
	
	method ejeX() {return 6}
	
	method ejeY() {return 0}
		
	method position(){
		return game.at(self.ejeX(),self.ejeY())
	}
	
	method image() { return self.nombre() }	
	
	method activar()
	
	method nombre()
	
}

class BotonEmpezar inherits Boton {
	
	override method ejeY(){return 8}
	
	override method activar(){
		game.clear()
		controladorDeNivel.nivel().init()
	}
	
	override method nombre(){
		return "botonEmpezar.png"
	}
}

class BotonInstrucciones inherits Boton {

	override method ejeY(){return 7}
	
	override method activar(){
		game.say(self, controladorDeNivel.nivel().descripcionDeObjetivos())
	}
	
	override method nombre(){
		return "botonInstrucciones.png"
	}
}
	
class BotonSalir inherits Boton {
	
	override method ejeY(){return 5}
	
	override method activar(){
		game.stop()
	}
	
	override method nombre(){
		return "botonSalir.png"
	}

}

