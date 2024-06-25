import wollok.game.*
import jugador.*
import niveles.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*

//MENUES
class Menu {

	const objetosMenu = []
	var posicionBoton = 0
	const property position = game.at(0, 0)

	method botonesDelMenuActual()

	method limiteInferiorEjeY() {
		return 2
	}

	method limiteSuperiorEjeY() {
		return 5
	}

	method limiteIndiceOpciones() {
		return objetosMenu.size() - 1
	}

	method agregarBotonoesAlMenu() {
		self.botonesDelMenuActual().forEach({ boton => objetosMenu.add(boton)})
	}

	method objetosMenu() {
		return objetosMenu
	}

	method salir() {
		game.stop()
	}

	method image() {
		return "fondoMenu.png"
	}

	method inicializarVisorDeSeleccion() {
		visorDeSeleccion.menuActual(self)
		visorDeSeleccion.irAPosicionInicial()
		posicionBoton = 0
	}

	method init() {
		game.cellSize(64)
		game.width(20)
		game.height(10)
		self.agregarBotonoesAlMenu()
		game.addVisual(self)
		self.visuales()
		self.inicializarVisorDeSeleccion()
		game.addVisual(visorDeSeleccion)
		keyboard.down().onPressDo{ posicionBoton = (posicionBoton + 1).min(self.limiteIndiceOpciones())
			visorDeSeleccion.moverAbajo()
		}
		keyboard.enter().onPressDo{ self.objetosMenu().get(posicionBoton).activar()}
		keyboard.up().onPressDo{ posicionBoton = (posicionBoton - 1).max(0)
			visorDeSeleccion.moverArriba()
		}
		game.addVisual(visorDeRanking)
	}

	method visuales() {
		self.botonesDelMenuActual().forEach{ boton => game.addVisual(boton)}
	}

}

object menuInicial inherits Menu {

	override method botonesDelMenuActual() {
		return [ new BotonEmpezar(), new BotonInstrucciones(), new BotonCreditos(), new BotonSalir() ]
	}

}

object menuTransicion inherits Menu {

	override method botonesDelMenuActual() {
		return [ new BotonEmpezar(), new BotonInstrucciones(), new BotonCanjear(), new BotonSalir() ]
	}

	override method image() {
		return "fondoMenuTransicion.png"
	}

}

class SubMenu inherits Menu {

	const property menuAnterior = controladorDeNivel.menu()

	override method init() {
		super()
		game.addVisual(self.contenidoSubmenu())
	}

	method contenidoSubmenu()

	override method botonesDelMenuActual() {
		return [ new BotonVolver() ]
	}

	override method limiteInferiorEjeY() {
		return 1
	}

	override method limiteSuperiorEjeY() {
		return 1
	}

}

object menuCanjear inherits Menu {

	override method botonesDelMenuActual() {
		return [ new BotonDuplicarMonedas(), new BotonDuplicarTiempo() ]
	}

	override method limiteInferiorEjeY() {
		return 4
	}

}

object menuInstrucciones inherits SubMenu {

	override method contenidoSubmenu() {
		return controladorDeNivel.nivel().instrucciones()
	}

}

object menuCreditos inherits SubMenu {

	override method contenidoSubmenu() {
		return creditos
	}

}

//INSTRUCCIONES 
class Instrucciones {

	method position() {
		return game.at(7, 2)
	}

	method image()

}

object instruccionesMenuInicial inherits Instrucciones {

	override method image() {
		return "instruccionesMenuInicial.png"
	}

}

object instruccionesNivel1 inherits Instrucciones {

	override method image() {
		return "instruccionesNivel1.png"
	}

}

object instruccionesNivel2 inherits Instrucciones {

	override method image() {
		return "instruccionesNivel2.png"
	}

}

object creditos inherits Instrucciones {

	override method image() {
		return "creditos.png"
	}

}

//BOTONES
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

	method activar()

	method nombre()

}

class BotonEmpezar inherits Boton {

	override method ejeY() {
		return 5
	}

	override method nombre() {
		return "botonEmpezar.png"
	}

	override method activar() {
		game.clear()
		controladorDeNivel.nivel().iniciar()
	}

}

class BotonInstrucciones inherits Boton {

	override method ejeY() {
		return 4
	}

	override method activar() {
		game.clear()
		menuInstrucciones.init()
	}

	override method nombre() {
		return "botonInstrucciones.png"
	}

}

class BotonCreditos inherits Boton {

	override method ejeY() {
		return 3
	}

	override method activar() {
		game.clear()
		menuCreditos.init()
	}

	override method nombre() {
		return "botonCreditos.png"
	}

}

class BotonCanjear inherits Boton {

	var property activado = false

	override method ejeY() {
		return 3
	}

	method estado() {
		if (jugador.monedas() >= juego.monedasNecesariasParaCanjear()) activado = true else activado = false
	}

	override method activar() {
		self.estado()
		self.validarEstado()
		game.clear()
		menuCanjear.init()
	}

	method validarEstado() {
		if (not activado) {
			self.error("No tiene suficientes monedas para Canjear")
		}
	}

	override method nombre() {
		self.estado()
		return "botonCanjear" + self.activado().toString() + ".png"
	}

}

class BotonDuplicador inherits Boton {

	override method activar() {
		game.clear()
		jugador.monedas(jugador.monedas() - 1)
		self.potenciador()
		controladorDeNivel.nivel().iniciar()
	}

	method potenciador()

	override method nombre() {
		return "botonDuplicar" + self.objetoADuplicar().toString() + ".png"
	}

	method objetoADuplicar()

}

class BotonDuplicarMonedas inherits BotonDuplicador {

	override method ejeY() {
		return 5
	}

	override method objetoADuplicar() {
		return "Monedas"
	}

	override method potenciador() {
		jugador.duplicarMonedas()
	}

}

class BotonDuplicarTiempo inherits BotonDuplicador {

	override method ejeY() {
		return 4
	}

	override method objetoADuplicar() {
		return "Tiempo"
	}

	override method potenciador() {
		jugador.duplicarTiempo()
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

class BotonVolver inherits Boton {

	override method ejeY() {
		return 1
	}

	override method activar() {
		game.clear()
		controladorDeNivel.menu().init()
	}

	override method nombre() {
		return "botonVolver.png"
	}

}

