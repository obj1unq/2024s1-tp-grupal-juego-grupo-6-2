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
			
	method instrucciones(){
		return visorInstruccionesMenuTransicion.text()
	}
	
	method salir(){
		game.stop()
	}
	
	method fondo(){return "fondoMenu.png"}
	
	method init(){
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.boardGround(self.fondo()) // background
		game.addVisual(botonEmpezar)
		game.addVisual(botonInstrucciones)
		game.addVisual(botonSalir)
		game.addVisualIn(visorDeSeleccion, game.at(objetosMenu.get(posicionBoton).positionX(), objetosMenu.get(posicionBoton).positionY()-2))
		/*keyboard.down().onPressDo{posicionBoton = posicionBoton + 1}
		keyboard.right().onPressDo{ objetosMenu.get(posicionBoton).activar()}
		keyboard.left().onPressDo{ objetosMenu.get(posicionBoton).desactivar()}
		keyboard.up().onPressDo{ posicionBoton = posicionBoton - 1 }
		*/
	}
	
	method siguiente()
	
}

object menuInicial inherits Menu {
	
	override method siguiente(){
		return nivel1
	}
	
	override method instrucciones(){
		return visorInstruccionesMenuInicial.text()
	}
	
	override method init(){
		super() 
		game.addVisualIn(visorMenuInicial, visorMenuInicial.position())
	}
}

object menuTransicion1 inherits Menu {
	
	override method siguiente(){
		return nivel2
	}
		
}

object menuTransicion2 inherits Menu {
	
	override method siguiente(){
		return nivel3
	}
	
}

object menuTransicion3 inherits Menu {
	
	override method siguiente(){
		return menuInicial
	}
	
}

class Boton {
	method positionX() {return 5}
	
	method positionY() {return 0}
		
	method position(){
		return game.at(self.positionX(),self.positionY())
	}
	
	method image() { return self + ".png" }	
	
	method activar(menu)
	
	method desactivar(menu){}
	
}

object botonEmpezar inherits Boton {
	
	override method positionY(){return 3}
		
	override method activar(menu){
		menu.siguiente().init()
	}
}

object botonInstrucciones inherits Boton {
	
	override method positionY(){return 5}
	
		override method activar(menu){
		menu.instrucciones()
	}
	
}
	
object botonSalir inherits Boton {
	
	override method positionY(){return 9}
	
	override method activar(menu){
		game.stop()
	}

}

object visorDeSeleccion{
var property position = game.at(0,0)
	
	method image() {
		return "moneda.png"
	}
}