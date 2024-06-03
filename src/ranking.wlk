object ranking {

	const ranking = []

	method hayValores() {
		return ranking.size() > 0
	}

	method top() {
		return if (self.hayValores()) ranking.max() else 0
	}

	method guardar(monedas) {
		ranking.add(monedas)
	}

}

