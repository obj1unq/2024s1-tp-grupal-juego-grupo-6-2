import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*


class Menu {
	
	var posicionBoton = 0
	const property position = game.at(0,0)
			
	method instrucciones(){
		return self.tipoDeInstrucciones().text()
	}
	
	method objetosMenu(){
		return [new BotonEmpezar(), new BotonInstrucciones(instrucciones = instruccionesMenuInicial), new BotonCreditos(instrucciones = creditos), new BotonSalir()]
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
		game.addVisual(self.objetosMenu().get(0))
		game.addVisual(self.objetosMenu().get(1))
		game.addVisual(self.objetosMenu().get(2))
		game.addVisual(self.objetosMenu().get(3))
		game.addVisual(visorDeSeleccion)
		
		
		keyboard.down().onPressDo{
			posicionBoton = posicionBoton + 1
			visorDeSeleccion.moverAbajo()
		}
		
		keyboard.enter().onPressDo{ 
			self.objetosMenu().get(posicionBoton).activar()
			
		}
		
		keyboard.up().onPressDo{ 
			posicionBoton = posicionBoton - 1
			visorDeSeleccion.moverArriba()
		}
		
		
		keyboard.backspace().onPressDo{ 
			self.objetosMenu().get(posicionBoton).desactivar()
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
	override method image(){return "fondoMenuTransicion.png"}
	
	override method objetosMenu(){
		return [new BotonEmpezar(), new BotonInstrucciones(instrucciones = instruccionesMenuTransicion), new BotonCanjear(), new BotonSalir()]
	}
		
}

class Boton {
	
	method ejeX() {return 8}
	
	method ejeY() {return 0}
		
	method position(){
		return game.at(self.ejeX(),self.ejeY())
	}
	
	method image() { return self.nombre() }	
	
	method activar()
	
	method desactivar(){}
	
	method nombre()
	
}

class BotonEmpezar inherits Boton {
	
	override method ejeY(){return 5}
	
	override method activar(){
		game.clear()
		controladorDeNivel.nivel().iniciar()	
	}
	
	override method nombre(){
		return "botonEmpezar.png"
	}
}

class BotonInstrucciones inherits Boton {
	const instrucciones

	override method ejeY(){return 4}
	
	override method activar(){
		instrucciones.activar()
	}
	
	override method desactivar(){
		instrucciones.desactivar()
	}
	
	override method nombre(){
		return "botonInstrucciones.png"
	}
}

class Instrucciones {
	var property estado = false

	method position()

	method image()
	
	method activar(){
		game.addVisual(self)
		self.estado(true)
	}
	
	method desactivar(){
		game.removeVisual(self)
		self.estado(false)	
	}	
}

object instruccionesMenuInicial inherits Instrucciones {
	override method image(){
		return "fondoInstruccionesMenuInicial.png"
	}
	
	override method position(){
		return game.at(12,4)
	}
}

object instruccionesMenuTransicion inherits Instrucciones {
	override method image(){
		return "fondoInstruccionesMenuTransicion.png"
	}
	
	override method position(){
		return game.at(12,4)
	}
}

object creditos inherits Instrucciones {
	override method image(){
		return "creditos.png"
	}
	
	override method position(){
		return game.at(12,4)
	}
}
	
class BotonCreditos inherits Boton {
	const instrucciones
	
	override method ejeY(){return 3}
	
	override method activar(){
		instrucciones.activar()
	}
		
	override method desactivar(){
		instrucciones.desactivar()
	}
	
	override method nombre(){
		return "botonCreditos.png"
	}
}

class BotonCanjear inherits Boton {

	override method ejeY(){return 3}
	
	override method activar(){
		game.say(self, controladorDeNivel.nivel().descripcionDeObjetivos())
	}
	
	method estado(){
		return false
	}
	
	override method nombre(){
		return "botonCanjear" + self.estado().toString() + ".png"
	}
}

class BotonDuplicarMonedas inherits Boton {

	override method ejeY(){return 4}
	
	override method activar(){
		jugador.monedas(jugador.monedas()-10)
		jugador.potenciadorMonedas(2)
		
	}
	
	override method nombre(){
		return "botonDuplicarMonedas.png"
	}
}

class BotonDuplicarTiempo inherits Boton {

	override method ejeY(){return 4}
	
	override method activar(){
		jugador.monedas(jugador.monedas()-10)
		jugador.potenciadorTiempo(2)
	}
	
	override method nombre(){
		return "botonDuplicarTiempo.png"
	}
}	
	
class BotonSalir inherits Boton {
	
	override method ejeY(){return 2}
	
	override method activar(){
		game.stop()
	}
	
	override method nombre(){
		return "botonSalir.png"
	}

}

