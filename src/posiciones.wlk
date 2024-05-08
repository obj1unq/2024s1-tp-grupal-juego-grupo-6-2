import wollok.game.*
import niveles.*
import objetos.*
import jugador.*


object tablero {
	
	const property jugadores = #{jugador}
	
	method esJugador(objeto){
		return self.jugadores().contains(objeto)
	}
	
	method pertenece(position) {
		return position.x().between(0, game.width() - 1) &&
			   position.y().between(0, game.height()-1) 
	}
	
	method puedeIr(desde, hacia) {
		return self.pertenece(hacia.siguiente(desde))	
	}
		
	
	method puedeMover(hacia, objetoQueSeMueve){
		return  objetoQueSeMueve.puedeMover() && self.puedeIr(objetoQueSeMueve.position(), hacia) 
	}
	
}

//

class Baldosa {
	const property position 
	
	method colisionarCon(objeto){
		//if(objeto!= jugador){
		if(not tablero.esJugador(objeto)){
			game.removeVisual(objeto)
		}
	}
	
	method image(){
		return "piso.png"
		
	}
	
}

object creadorDeBaldosa{
	
	method crearBaldosas(){
		(0..(game.width() - 1)).forEach{x => self.crearBaldosa(x) } 
	}
	
	method crearBaldosa(x){
		const baldosa = new Baldosa(position = game.at(x, 0))
		game.addVisual(baldosa)
		game.onCollideDo(baldosa, {objeto => baldosa.colisionarCon(objeto)})
			
	}
	
}

//GRAVEDAD
object gravedad {
	method aplicarEfectoCaida(objetoACaer){
		//self.validarEstadoSiEsJugador(objetoACaer)
		if (tablero.puedeMover(abajo, objetoACaer)) {
			objetoACaer.position(abajo.siguiente(objetoACaer.position()))
		}
	}
	
	method validarEstadoSiEsJugador(objeto){
		if(tablero.esJugador(objeto)){
			objeto.validarQuePuedeMover()
		}
	}
}

//DIRECCIONES 

object arriba {
	method siguiente(position) {
		return position.up(1)
	}
}

object abajo {
	method siguiente(position) {
		return position.down(1)
	}	
}

object izquierda {
	method siguiente(position) {
		return position.left(1)
	}
}
object derecha {
	method siguiente(position) {
		return position.right(1)
	}
}