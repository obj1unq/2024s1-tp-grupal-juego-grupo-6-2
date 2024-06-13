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
	
	method esAtravesable() {
		return true
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

class Craneo inherits ObjetoQueCae {

	const property image = "craneo.png"

	override method accionAlColisionarCon(objeto) {
		objeto.perder()
	}

}

class CreadorDeCraneos inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Craneo(nivel=nivel, position = position)
	}

}

class Reloj inherits ObjetoQueCae {

	const property image = "reloj.png"
	

	override method accionAlColisionarCon(objeto) {
		self.descontarTiempo()
	}

	method descontarTiempo() {
		const tiempoADescontar = 0.max(controladorDeNivel.nivel().tiempo() - 5)
		controladorDeNivel.nivel().descontarTiempo(tiempoADescontar)
		game.say(jugador, "¡Uy! Perdí 5 segundos")
	}

}

class CreadorDeRelojes inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Reloj(nivel = nivel, position = position)
	}

}


class Cofre {

	const x = (0 .. 10).anyOne()

	method position() {
		return game.at(x, 1)
	}

	method image() {
		return "cofre.png"
	}

	method esAtravesable() {
		return false
	}

	method colisionarCon(objeto) {
	}

}









