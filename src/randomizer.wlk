import wollok.game.*

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

