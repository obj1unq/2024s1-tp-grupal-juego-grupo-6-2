import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*

class ObjetoQueCae {
	
	method puedeMover(){
		return true
	}
	
}

class Moneda inherits ObjetoQueCae {

	var property position
	const property velocidadDeCaida = 3000

	method image() {
		return "moneda.png"
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method esAtravesable() {
		return false
	}

	method colisionarCon(objeto) {
		objeto.monedasAtrapadas().add(self)
		self.desaparecer()
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
	const property velocidadDeCaida = 1000

	method image() {
		return "hielo.png"
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method esAtravesable() {
		return false
	}

	method colisionarCon(objeto) {
		objeto.congelarse()
		self.desaparecer()
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
	const property velocidadDeCaida = 5000

	method image() {
		return "vida.png"
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method esAtravesable() {
		return false
	}

	method colisionarCon(objeto) {
		objeto.vida(100)
		self.desaparecer()
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

	method esAtravesable() {
		return false
	}

	method colisionarCon(objeto) {
		objeto.perder()
		self.desaparecer()
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

object randomizer {

	method position() {
		return game.at((0 .. game.width() - 1 ).anyOne(), (game.height() - 1))
	}

	method emptyPosition() {
		const position = self.position()
		if (game.getObjectsIn(position).isEmpty()) {
			return position
		} else {
			return self.emptyPosition()
		}
	}

}

