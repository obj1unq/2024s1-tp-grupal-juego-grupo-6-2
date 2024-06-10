import wollok.game.*
import jugador.*
import objetos.*
import posiciones.*
import randomizer.*
import visores.*
import menu.*

class Nivel {
	const visorMonedas = new VisorMonedas()
	const visorVida = new VisorVida()
	const visorTiempo = new VisorDeTiempo()
	const visorNivel = new VisorDeNivel(nivel = self)
	const visorFinDeTiempo = new VisorFinDeTiempo()
	
	var property tiempo = self.tiempoDeJuego()
	
	method descontarTiempo() {
		if(self.tieneTiempo())
		tiempo -= self.segundosADescontar()
		
	}

	method tieneTiempo() {
		return tiempo > 0
	}
	
	method tiempoDeJuego(){
		return  30
	}
			
	method segundosADescontar(){
		return 1
	}
	
	method descripcionDeObjetivos() {
		return "Reuní la mayor cantidad de monedas antes de que finalice el tiempo"
	}

	method objetosCreados()

	method gravedadJugador()

	method factoriesDeObjetos(){
		return [new CreadorDeMonedas(nivel=self), new CreadorDeHielos(nivel=self), new CreadorDeVidas(nivel=self), new CreadorDeMazas(nivel=self) ]
	}

	method fondo()

	method siguiente()
	
	method nivel() {return self}
	
	method pasarDeNivel() {
		return if (not self.tieneTiempo()){ 
			game.clear()
			game.addVisual(visorFinDeTiempo)
			visorFinDeTiempo.text()
			game.schedule(3000, { new MenuTransicion(siguienteNivel = self.siguiente()).init()})
		} else {} 
	}
	
	method init() {

		
		game.cellSize(64)
		game.width(20)
		game.height(10)
		game.boardGround(self.fondo()) 
		game.addVisual(jugador)
		game.onCollideDo(jugador, { objeto => objeto.colisionarCon(jugador)})
		keyboard.right().onPressDo{ jugador.mover(jugandoDerecha)}
		keyboard.left().onPressDo{ jugador.mover(jugandoIzquierda)}
		keyboard.up().onPressDo{ jugador.mover(saltando)}
		creadorDeBaldosas.crearBaldosas()
		game.onTick(self.gravedadJugador(), "GRAVEDAD_JUGADOR", { gravedad.aplicarEfectoCaida(jugador)})
		game.onTick(600, "CREAR OBJETOS", { self.factoriesDeObjetos().anyOne().nuevoObjeto()})
		game.onTick(300, "GRAVEDAD", { self.objetosCreados().forEach{ objeto => gravedad.aplicarEfectoCaida(objeto)}})
		game.onTick(1000, "CRONOMETRO", { visorTiempo.descontar(1)})
		game.addVisual(visorVida)
		game.addVisual(visorMonedas)
		game.addVisual(visorTiempo)
		game.addVisual(visorNivel)
	}
}

object nivel1 inherits Nivel {

	const property objetosCreados = []
	

	override method gravedadJugador() {
		return 1000
	}

	override method fondo() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	override method init() {
		super()
		game.title("Nivel 1")
	}

	override method siguiente() {
		return nivel2
	}
	
}

object nivel2 inherits Nivel {

	const property objetosCreados = []

	override method gravedadJugador() {
		return 1000
	}
	
	override method tiempoDeJuego(){
		return  20
	}
	
	override method fondo() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	override method init() {
		super()
		game.title("Nivel 2")
	}

	override method siguiente() {
		return nivel3
	}

}

object nivel3 inherits Nivel {

	const property objetosCreados = []

	override method gravedadJugador() {
		return 1000
	}
	
	override method tiempoDeJuego(){
		return  10
	}

	override method fondo() {
		return "fondoNivel1.jpg"
	}

	method remove(objeto) {
		objetosCreados.remove(objeto)
	}

	override method init() {
		super()
		game.title("Nivel 3")
	}

	override method siguiente() {
		
	}
	
}



