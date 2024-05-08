import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*
import randomizer.*

class ObjetoQueCae {

	const property velocidadDeCaida = null

	method puedeMover() {
		return true
	}

	method colisionarCon(objeto) {
		self.accionAlColisionarCon(objeto)
		self.desaparecer()
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	// Metodo abstracto
	method accionAlColisionarCon(objeto)

}

class Moneda inherits ObjetoQueCae {

	var property position

	method image() {
		return "moneda.png"
	}

	override method accionAlColisionarCon(objeto) {
		objeto.monedasAtrapadas().add(self)
	}

}

object creadorDeMonedas {

	method nuevoObjeto() {
		const objeto = new Moneda(position = randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
		return objeto
	}

}

class Hielo inherits ObjetoQueCae {

	var property position

	method image() {
		return "hielo.png"
	}

	override method accionAlColisionarCon(objeto) {
		objeto.congelarse()
	}

}

object creadorDeHielos {

	method nuevoObjeto() {
		const objeto = new Hielo(position = randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
		return objeto
	}

}

class Vida inherits ObjetoQueCae {

	var property position

	method image() {
		return "vida.png"
	}

	override method accionAlColisionarCon(objeto) {
		objeto.vida(100)
	}

}

object creadorDeVidas {

	method nuevoObjeto() {
		const objeto = new Vida(position = randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
		return objeto
	}

}

class Maza inherits ObjetoQueCae {

	var property position
	const property image = "maza.png"

	method desaparecer() {
		game.removeVisual(self)
	}

	override method accionAlColisionarCon(objeto) {
		objeto.perder()
	}

}

object creadorDeMazas {

	method nuevoObjeto() {
		const objeto = new Maza(position = randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel1.objetosCreados().add(objeto)
		return objeto
	}

}


