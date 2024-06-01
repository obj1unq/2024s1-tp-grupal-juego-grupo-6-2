import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*
import randomizer.*

class ObjetoQueCae {
	var property position
	const property velocidadDeCaida = null

	method limiteInferior() = 0
	
	method puedeCaer() {
		return true
	}

	method colisionarCon(objeto) {
		self.accionAlColisionarCon(objeto)
		self.desaparecer()
	}

	method desaparecer() {
		game.removeVisual(self)
		nivel.nivel().remove(self)
	}

	// Metodo abstracto
	method accionAlColisionarCon(objeto) {
		
	}

}

class Moneda inherits ObjetoQueCae {

	method image() {
		return "moneda.png"
	}
	
	method valor(){
		return 1
	}

	override method accionAlColisionarCon(personaje) {
		personaje.sumarMoneda(self.valor())
	}

}

class ObjetoQueCaeFactory {
	
	method nuevoObjeto() {
		const objeto = self.crear( randomizer.emptyPosition() )
		game.addVisual(objeto)
		nivel.nivel().objetosCreados().add(objeto) 
		return objeto
	}
	
	method crear(position)
}


object creadorDeMonedas inherits ObjetoQueCaeFactory { 

	override method crear(position) {
		return  new Moneda(position = position)
	}
}

class Hielo inherits ObjetoQueCae {

	method image() {
		return "hielo.png"
	}

	override method accionAlColisionarCon(objeto) {
		objeto.congelarse()
	}

}

object creadorDeHielos inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return  new Hielo (position = position)
	}
}

class Vida inherits ObjetoQueCae {

	method image() {
		return "vida.png"
	}

	override method accionAlColisionarCon(objeto) {
		objeto.sumarVida()
	}

}

object creadorDeVidas inherits ObjetoQueCaeFactory {
	
	override method crear(position) {
		return  new Vida (position = position)
	}
}

class Maza inherits ObjetoQueCae {

	const property image = "maza.png"

	override method desaparecer() {
		game.removeVisual(self)
	}

	override method accionAlColisionarCon(objeto) {
		objeto.restarVida()
	}

}

object creadorDeMazas inherits ObjetoQueCaeFactory{
	override method crear(position) {
		return  new Maza (position = position)
	}

}


