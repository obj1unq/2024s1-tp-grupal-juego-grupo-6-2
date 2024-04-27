import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*

class Color {
	var property position = randomizer.emptyPosition()
	var property nombre = null
	
	
	
	method image(){
		// console.println(colores.anyOne()+ "png")
		return nombre + ".png"
	}
	
	method colisionarCon(personaje) {
		personaje.atraparColor(self)
		creadorDeColores.coloresCreados().remove(self)
		self.desaparecer()
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
	method caer(){
		if (self.puedeMover(abajo)) {
			position = abajo.siguiente(self.position())
		}
	}
	
	method puedeMover(direccion){
		return  tablero.puedeIr(self.position(), direccion)
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
	
object creadorDeColores {
	const maximaCantidadDeColores = 20
	const property nombreDeColores = ["negro", "rojo", "rosa", "verde", "azul", "amarillo"]
	
	const property coloresCreados = []
	
	method crearColor() {
		if (coloresCreados.size() < maximaCantidadDeColores) {
		
			coloresCreados.add(self.nuevoColor())
		}
		

	}

	method nuevoColor(){
		const color = new Color()
		
		color.nombre(nombreDeColores.anyOne())
		game.addVisual(color)
		coloresCreados.add(color)
		return color
	}
	
	
}
