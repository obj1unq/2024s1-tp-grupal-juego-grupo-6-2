import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*


class Menu {
	const objetosMenu =[botonEmpezar, botonInstrucciones, botonSalir]
	var posicionBoton = 0
	
	const botonEmpezar = new BotonEmpezar (menu=self)
	const botonInstrucciones = new BotonInstrucciones(menu=self)
	const botonSalir = new BotonSalir ()
			
	method instrucciones(){
		return self.tipoDeInstrucciones().text()
	}
	
	method tipoDeInstrucciones(){
		return new VisorInstruccionesMenuTransicion()	
	}
	
	method salir(){
		game.stop()
	}
	
	method fondo(){return "fondoMenu.png"}
	
	method init(){
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.boardGround(self.fondo()) 
		game.addVisual(botonEmpezar)
		game.addVisual(botonInstrucciones)
		game.addVisual(botonSalir)
		game.addVisual(visorDeSeleccion)
		
		keyboard.down().onPressDo{
			posicionBoton = posicionBoton + 1
			visorDeSeleccion.moverAbajo()
		}
		
		keyboard.right().onPressDo{ 
			objetosMenu.get(posicionBoton).activar()
			visorDeSeleccion.moverArriba()
		}
		
		keyboard.up().onPressDo{ 
			posicionBoton = posicionBoton - 1
		}
	}
	
	method siguiente()
	
}

object menuInicial inherits Menu {
	
	override method siguiente(){
		return nivel1
	}
	
	override method tipoDeInstrucciones(){
		return new VisorInstruccionesMenuInicial()
	}
}

class MenuTransicion inherits Menu {
	const siguienteNivel
	
	override method siguiente(){
		return siguienteNivel
	}
		
}

class Boton {
	
	method ejeX() {return 5}
	
	method ejeY() {return 0}
		
	method position(){
		return game.at(self.ejeX(),self.ejeY())
	}
	
	method image() { return self + ".png" }	
	
	method activar()
	
}

class BotonEmpezar inherits Boton {
	const menu
	
	override method ejeY(){return 3}
	
	override method activar(){
		menu.siguiente().init()
	}
	
}

class BotonInstrucciones inherits Boton {
	const menu
	
	override method ejeY(){return 5}
	
	override method activar(){
		game.say(self, menu.instrucciones())
	}
}
	
class BotonSalir inherits Boton {
	
	override method ejeY(){return 9}
	
	override method activar(){
		game.stop()
	}

}

