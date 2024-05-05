import wollok.game.*
import niveles.*
import objetos.*
import jugador.*


object tablero {
	
	method pertenece(position) {
		return position.x().between(0, game.width() - 1) &&
			   position.y().between(0, game.height()-1) 
	}
	
	method puedeIr(desde, direccionAIr) {
		return self.pertenece(direccionAIr.siguiente(desde))	
	}
		
	/*method hayObstaculo(position) {
		const visuales = game.getObjectsIn(position)
		return visuales.any({visual => not visual.esAtravesable()})
	}*/
	
	method puedeMover(direccionAMover, objetoQueSeMueve){
		return  self.puedeIr(objetoQueSeMueve.position(), direccionAMover) 
	}
	
}

//

class Baldosa {
	const property position 
	
	method colisionarCon(objeto){
		if(objeto!= jugador){
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
		if (tablero.puedeMover(abajo, objetoACaer)) {
			objetoACaer.position(abajo.siguiente(objetoACaer.position()))
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