import wollok.game.*
import niveles.*
import colores.*
import posiciones.*


object jugador {
	var property position = game.at(0,0)
	const nivel = nivel1
	const coloresAtrapados = []
	
	var estadoDeJugador = jugandoDerecha


	method estadoDeJugador(_estadoDeJugador) {
		estadoDeJugador = _estadoDeJugador
		estadoDeJugador.activar()
	}
	
	method image() { 
		return "jugador-" + estadoDeJugador.toString() + ".png"
	}
	
	method ganar(){
		
		if (coloresAtrapados.size() >=10){
		estadoDeJugador = ganador
		estadoDeJugador.activar()}
	}
	
	method perder(){
		if (coloresAtrapados.size() ==0){
		estadoDeJugador = perdedor
		estadoDeJugador.activar()}
	}
	
	method moverIzquierda(){
		estadoDeJugador = jugandoIzquierda
		estadoDeJugador.activar()
	}
	
	method moverDerecha(){
		estadoDeJugador = jugandoDerecha
		estadoDeJugador.activar()
	}
	
	method atraparColor(color){
		coloresAtrapados.add(color)
		color.desaparecer()
	}
	
	method chocarConColorEquivocado(color){
		coloresAtrapados.remove(coloresAtrapados.last())
		color.desaparecer()
	}
	
}
	
// ESTADOS DEL JUGADOR

object jugandoDerecha {
	method puedeMover() = true	

	method activar() {}
}

object jugandoIzquierda {
	method puedeMover() = true	

	method activar() {}
}

object ganador{
	method puedeMover() = false	

	method activar() {
		game.say(jugador, "Gané!")
		game.schedule(5000, {game.stop()})
	}
}

object perdedor{
		method puedeMover() = false	

	method activar() {
		game.say(jugador, "Perdí!")
		game.schedule(5000, {game.stop()})
	}
}
