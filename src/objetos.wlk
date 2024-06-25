import wollok.game.*
import jugador.*
import niveles.*
import posiciones.*
import randomizer.*
import visores.*

object musica {
	var property activada = true
	
	method sonar(){
		if (activada){
		const musicaAmbiente = self.sonido()
		musicaAmbiente.shouldLoop(true)
		musicaAmbiente.volume(0.3)
		game.schedule(500, {musicaAmbiente.play()})
			
		}
	}
	
	method sonido(){
		return game.sound("musicaFondo.mp3")
	}
}

class ObjetoQueCae {

	var property position
	const property nivel
	const property velocidadDeCaida = null
	var property sonido = true

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
		if (sonido) {self.sonido().play()}
	}

	method esAtravesable() {
		return true
	}
	
	method sonido()

}

class Moneda inherits ObjetoQueCae {

	method valor() {
		return 1
	}

	method image() {
		return "moneda.png"
	}

	override method accionAlColisionarCon(personaje) {
		super(personaje)
		personaje.sumarMoneda(self.valor())

	}
	
	override method sonido(){
		return game.sound("coin.wav")
	}

}

class ObjetoQueCaeFactory {

	const nivel

	method nuevoObjeto() {
		const objeto = self.crear(randomizer.emptyPosition())
		game.addVisual(objeto)
		nivel.objetosCreados().add(objeto)
		return objeto
	}

	method crear(position)

}

class CreadorDeMonedas inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Moneda(nivel = nivel, position = position)
	}

}

class Hielo inherits ObjetoQueCae {

	method image() {
		return "hielo.png"
	}

	override method accionAlColisionarCon(objeto) {
		super(objeto)
		objeto.congelarse()
	}
	
	override method sonido(){
		return game.sound("hielo.ogg")
	}

}

class CreadorDeHielos inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Hielo(nivel = nivel, position = position)
	}

}

class Vida inherits ObjetoQueCae {

	method image() {
		return "vida.png"
	}

	override method accionAlColisionarCon(objeto) {
		super(objeto)
		objeto.sumarVida()
	}
	
	override method sonido(){
		return game.sound("vida.mp3")
	}
}

class CreadorDeVidas inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Vida(nivel = nivel, position = position)
	}

}

class Maza inherits ObjetoQueCae {

	const property image = "maza.png"

	override method desaparecer() {
		game.removeVisual(self)
	}

	override method accionAlColisionarCon(objeto) {
		super(objeto)
		objeto.restarVida()
	}
	
	override method sonido(){
		return game.sound("maza.wav")
	}
}

class CreadorDeMazas inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Maza(nivel = nivel, position = position)
	}

}


class Craneo inherits ObjetoQueCae {

	const property image = "craneo.png"

	override method accionAlColisionarCon(objeto) {
		super(objeto)
		objeto.perder()
	}
	
	override method sonido(){
		return game.sound("calavera.mp3")
	}
}

class CreadorDeCraneos inherits ObjetoQueCaeFactory {

	override method crear(position) {
		return new Craneo(nivel = nivel, position = position)
	}

}

class Reloj inherits ObjetoQueCae {

	const property image = "reloj.png"

	override method accionAlColisionarCon(objeto) {
		super(objeto)
		self.descontarTiempo()
	}

	method descontarTiempo() {
		controladorDeNivel.nivel().sumarTiempo()
		game.say(jugador, "¡Vamos! Tengo " + juego.tiempoAdicional() + " segundos más.")
	}
	
	override method sonido(){
		return game.sound("coin.wav")
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

