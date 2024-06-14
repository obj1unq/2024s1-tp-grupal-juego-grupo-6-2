import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*
import randomizer.*
import visores.*

class ObjetoQueCae {
	var property position
	const property nivel
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
		nivel.remove(self)
	}

	// Metodo abstracto
	method accionAlColisionarCon(objeto) {
		
	}

}

class Moneda inherits ObjetoQueCae {

	method valor(){
		return 1
	} 

	method image() {
		return "moneda.png"
	}
	
	override method accionAlColisionarCon(personaje) {
		personaje.sumarMoneda(self.valor())
	}

}

class ObjetoQueCaeFactory {
	const nivel 
	
	method nuevoObjeto() {
		const objeto = self.crear( randomizer.emptyPosition() )
		game.addVisual(objeto)
		nivel.objetosCreados().add(objeto) 
		return objeto
	}
	
	method crear(position)
}


class CreadorDeMonedas inherits ObjetoQueCaeFactory { 
	
	override method crear(position) {
		return  new Moneda(nivel = nivel,  position = position)
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

class CreadorDeHielos inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return  new Hielo (nivel=nivel, position = position)
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

class CreadorDeVidas inherits ObjetoQueCaeFactory {
	
	override method crear(position) {
		return  new Vida (nivel=nivel, position = position)
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

class CreadorDeMazas inherits ObjetoQueCaeFactory{
	
	override method crear(position) {
		return  new Maza (nivel=nivel, position = position)
	}

}


