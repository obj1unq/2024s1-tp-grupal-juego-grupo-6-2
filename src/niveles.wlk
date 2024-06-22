import ranking.*
import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*
import menu.*

class Nivel {

	const property objetosCreados = []
	var property tiempo = self.tiempoDeJuego()
	const property position = game.at(0, 0)
	const vidas = new CreadorDeVidas(nivel = self)
	const monedas = new CreadorDeMonedas(nivel = self)
	const hielos = new CreadorDeHielos(nivel = self)
	const mazas = new CreadorDeMazas(nivel = self)

	method sumarTiempo() {
		tiempo += 5
	}

	method descontarTiempo(cantidad) {
		return if (self.tieneTiempo()) {
			tiempo -= cantidad
		} else {
			self.pasarDeNivel()
		}
	}

	method tieneTiempo() {
		return tiempo > 0
	}

	method tiempoDeJuego() {
		return 10 * jugador.potenciadorTiempo()
	}

	method objetosCreados()

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	method gravedadJugador()

	method factoriesDeObjetos() {
		return [ vidas, monedas, hielos, mazas, monedas, monedas ]
	}

	method image()

	method nivel() {
		return self
	}

	method siguiente()

	method siguienteMenu()

	method pasarDeNivel() {
		game.clear()
		game.addVisual(visorFinDeTiempo)
		visorFinDeTiempo.text()
		controladorDeNivel.pasarNivel()
		self.cargarMenu()
	}

	method cargarMenu() {
		game.schedule(1000, { menuTransicion.init()})
	}

	method init() {
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.addVisual(self)
		game.addVisual(jugador)
		game.onCollideDo(jugador, { objeto => objeto.colisionarCon(jugador)})
		keyboard.right().onPressDo{ jugador.mover(jugandoDerecha)}
		keyboard.left().onPressDo{ jugador.mover(jugandoIzquierda)}
		keyboard.up().onPressDo{ jugador.mover(saltando)}
		creadorDeBaldosas.crearBaldosas()
		creadorDeEncabezado.crearEncabezado()
		game.onTick(self.gravedadJugador(), "GRAVEDAD_JUGADOR", { gravedad.aplicarEfectoCaida(jugador)})
		game.onTick(600, "CREAR OBJETOS", { self.factoriesDeObjetos().anyOne().nuevoObjeto()})
		game.onTick(300, "GRAVEDAD", { self.objetosCreados().forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		game.onTick(1000, "CRONOMETRO", { self.descontarTiempo(1)})
		game.addVisual(visorVida)
		game.addVisual(visorMonedas)
		game.addVisual(visorDeTiempo)
		game.addVisual(visorDeNivel)
		game.addVisual(visorDeRanking)
	}

	method desaparecer() {
	}

	method iniciar() {
		self.reestablecerTiempo()
		jugador.cambiarEstado(jugandoDerecha)
		self.init()
	}

	method reestablecerTiempo() {
		tiempo = self.tiempoDeJuego()
	}

	method instrucciones()

}

object controladorDeNivel {

	var nivel = nivel1
	var menu = menuInicial

	method pasarNivel() {
		nivel = nivel.siguiente()
		menu = nivel.siguienteMenu()
	}

	method nivel() {
		return nivel
	}

	method menu() {
		return menu
	}

	method reiniciarJuego() {
		juego.reiniciar()
		nivel = nivel1
		game.clear()
		menuInicial.init()
	}

}

object nivel1 inherits Nivel {

	override method gravedadJugador() {
		return 1000
	}

	override method image() {
		return "fondoNivel1.png"
	}

	override method siguiente() {
		return nivel2
	}

	override method siguienteMenu() {
		return menuTransicion
	}

	override method instrucciones() {
		return instruccionesMenuInicial
	}

}

object nivel2 inherits Nivel {

	override method gravedadJugador() {
		return 1000
	}

	override method tiempoDeJuego() {
		return 10 * jugador.potenciadorTiempo()
	}

	override method image() {
		return "fondoNivel2.png"
	}

	override method siguiente() {
		return nivel3
	}

	override method siguienteMenu() {
		return menuTransicion
	}

	override method factoriesDeObjetos() {
		return super() + [ new CreadorDeRelojes(nivel=self) ]
	}

	override method instrucciones() {
		return instruccionesNivel1
	}

}

object nivel3 inherits Nivel {

	override method gravedadJugador() {
		return 1000
	}

	override method tiempoDeJuego() {
		return 10 * jugador.potenciadorTiempo()
	}

	override method image() {
		return "fondoNivel3.png"
	}

	override method siguiente() {
		juego.reiniciar()
		return nivel1
	}

	override method siguienteMenu() {
		return menuInicial
	}

	override method factoriesDeObjetos() {
		const objetos = super()
		objetos.remove(vidas)
		return objetos + [ new CreadorDeCraneos(nivel=self), new CreadorDeRelojes(nivel=self) ]
	}

	override method cargarMenu() {
		game.schedule(1000, { menuInicial.init()})
	}

	override method instrucciones() {
		return instruccionesNivel2
	}

}

object juego {

	method reiniciar() {
		ranking.guardar(jugador.monedas())
		jugador.reiniciar()
	}

}

