import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*

class Menu {
	
	const objetosMenu = []

	var posicionBoton = 0
	const property position = game.at(0, 0)
	
	
	method botonesDelMenuActual(){
		return [ new BotonEmpezar(), new BotonInstrucciones(instrucciones = instruccionesMenuInicial), self.tercerBoton(), new BotonSalir() ]
	}

	method instrucciones() {
		return self.tipoDeInstrucciones().text()
	}

	method objetosDelMenu() {
//		 objetosMenu.add(self.botonesDelMenuActual())
		 self.botonesDelMenuActual().forEach({boton => objetosMenu.add(boton)})
	}
	
	method objetosMenu(){
		return objetosMenu
	}
	

	method tipoDeInstrucciones() {
		return new VisorInstruccionesMenuTransicion()
	}

	method salir() {
		game.stop()
	}

	method image() {
		return "fondoMenu.png"
	}

	method init() {
		game.cellSize(64)
		game.width(20)
		game.height(10)
		self.objetosDelMenu()
		game.addVisual(self)
		self.visuales()
		game.addVisual(visorDeSeleccion)
		keyboard.down().onPressDo{ posicionBoton = posicionBoton + 1
			visorDeSeleccion.moverAbajo()
		}
		keyboard.enter().onPressDo{ self.objetosMenu().get(posicionBoton).activar()}
		keyboard.up().onPressDo{ posicionBoton = posicionBoton - 1
			visorDeSeleccion.moverArriba()
		}
		keyboard.backspace().onPressDo{ self.objetosMenu().get(posicionBoton).desactivar()}
	}
	
	method visuales(){
		game.addVisual(self.objetosMenu().get(0))//empezar
		game.addVisual(self.objetosMenu().get(1))//instrucciones(ayuda)
		game.addVisual(self.objetosMenu().get(2))//creditos
		game.addVisual(self.objetosMenu().get(3))//salir
	}

	method tercerBoton()

}

object menuInicial inherits Menu {

	override method tipoDeInstrucciones() {
		return new VisorInstruccionesMenuInicial()
	}
	
	override method tercerBoton(){
		return new BotonCreditos(instrucciones = creditos)
	}
	

}

object menuTransicion inherits Menu {
	
	//const objetosMenu = [ new BotonEmpezar(), new BotonInstrucciones(instrucciones = instruccionesMenuTransicion), new BotonCanjear(), new BotonSalir() ]

	method canjearMonedas() {
	}

	override method image() {
		return "fondoMenuTransicion.png"
	}

	override method objetosMenu() {
		return objetosMenu
	}
	
	override method tercerBoton(){
		return new BotonCanjear()
	}


}

object menuCanjear inherits Menu {
	override method botonesDelMenuActual(){
		return [ new BotonDuplicarMonedas() , new BotonDuplicarTiempo() ]
	}
	
	override method tercerBoton(){
		
	}
	
	override method visuales(){
		game.addVisual(self.objetosMenu().get(0))//empezar
		game.addVisual(self.objetosMenu().get(1))//instrucciones(ayuda)
	}
	
}

class Boton {

	method ejeX() {
		return 8
	}

	method ejeY() {
		return 0
	}

	method position() {
		return game.at(self.ejeX(), self.ejeY())
	}

	method image() {
		return self.nombre()
	}

	method activar(){//ver!!! (preguntar)
		game.clear()
		controladorDeNivel.nivel().iniciar()
	}

	method desactivar() {
	}

	method nombre()

}

class BotonEmpezar inherits Boton {

	override method ejeY() {
		return 5
	} 

	override method nombre() {
		return "botonEmpezar.png"
	}

}

class BotonInstrucciones inherits Boton {

	const instrucciones

	override method ejeY() {
		return 4
	}

	override method activar() {
		instrucciones.activar()
	}

	override method desactivar() {
		instrucciones.desactivar()
	}

	override method nombre() {
		return "botonInstrucciones.png"
	}

}

class Instrucciones {

	var property estado = false

	method position()

	method image()

	method activar() {
		game.addVisual(self)
		self.estado(true)
	}

	method desactivar() {
		game.removeVisual(self)
		self.estado(false)
	}

}

object instruccionesMenuInicial inherits Instrucciones {

	override method image() {
		return "fondoInstruccionesMenuInicial.png"
	}

	override method position() {
		return game.at(12, 4)
	}

}

object instruccionesMenuTransicion inherits Instrucciones {

	override method image() {
		return "fondoInstruccionesMenuTransicion.png"
	}

	override method position() {
		return game.at(12, 4)
	}

}

object creditos inherits Instrucciones {

	override method image() {
		return "creditos.png"
	}

	override method position() {
		return game.at(12, 4)
	}

}

class BotonCreditos inherits Boton {

	const instrucciones

	override method ejeY() {
		return 3
	}

	override method activar() {
		instrucciones.activar()
	}

	override method desactivar() {
		instrucciones.desactivar()
	}

	override method nombre() {
		return "botonCreditos.png"
	}

}

class BotonCanjear inherits Boton {
	//subir y bajar en la posicion (cada menu debe saber su  limite inferior y superior)
	//hacer test


	var property estado = false
	const duplicadorMonedas = new BotonDuplicarMonedas()
	const dupllicadorDeTiempo = new BotonDuplicarTiempo()

	override method ejeY() {
		return 3
	}

	method actualizarEstado() {
		if (jugador.monedas() >= 10) {
			estado = true
		}else{
			estado = false
		}
	}
	
	override method activar() {
		self.validarEstado()
		game.clear()
		menuCanjear.init()
		game.addVisual(duplicadorMonedas)
		game.addVisual(dupllicadorDeTiempo)
	}
	
	override method desactivar() {
		game.removeVisual(self)
		game.removeVisual(self)
	}
	
	
	method validarEstado(){
		if (not estado){
			self.error("No tiene suficientes monedas para Canejar")
		}
	}

	

	override method nombre() {
		self.actualizarEstado()
		return "botonCanjear" + self.estado().toString() + ".png"
	}

}

class BotonDuplicador inherits Boton{
	
	override method ejeY(){
		return 2
	}
	
	override method activar(){
		jugador.monedas(jugador.monedas() - 10)
		self.potenciador(2)
		super()
	}
	
	method potenciador(cantidad)
	
	override method desactivar(){
		game.clear()
		menuTransicion.init()
	}
	
	override method nombre() {
		return "botonDuplicar" + self.objetoADuplicar().toString() + ".png"
	}
	
	method objetoADuplicar()
	
}

class BotonDuplicarMonedas inherits BotonDuplicador {

	override method ejeY() {
		return 3
	}

	override method objetoADuplicar(){
		return "Monedas"
	}

	override method potenciador(cantidad){
		return jugador.potenciadorMonedas(cantidad)
	}

}

class BotonDuplicarTiempo inherits BotonDuplicador {
	
	override method objetoADuplicar(){
		return "Tiempo"
	}
	
	override method potenciador(cantidad){
		return jugador.potenciadorTiempo(cantidad)
	}

}

class BotonSalir inherits Boton {

	override method ejeY() {
		return 2
	}

	override method activar() {
		game.stop()
	}

	override method nombre() {
		return "botonSalir.png"
	}

}

