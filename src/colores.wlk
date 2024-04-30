import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*

class Moneda {
	var property position 
	const property velocidadDeCaida = 3000
	
	method image(){
		return "moneda.png"
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
	method colisionarCon(objeto){
		
	}
}

object creadorDeMonedas {
	
	method nuevoObjeto(){
	const objeto = new Moneda(position = randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
	}
	
	method colisionarCon(objeto){
		
	}
}


class Hielo {
	var property position 
	const property velocidadDeCaida = 1000
	
	method image(){
		return "hielo.png"
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
	method colisionarCon(objeto){
		
	}
}

object creadorDeHielos {
	
	method nuevoObjeto(){
	const objeto = new Hielo(position = randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
	}
}

class Vida {
	var property position  
	const property velocidadDeCaida = 5000
	
	method image(){
		return "vida.png"
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
	method colisionarCon(objeto){
		
	}
}	

object creadorDeVidas {
	
	method nuevoObjeto(){
	const objeto = new Vida(position = randomizer.emptyPosition())
	
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
	}
}

object randomizer {
		
	method position() {
		return 	game.at((0.. game.width() - 1 ).anyOne(),(game.height() - 1)) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
}
	

