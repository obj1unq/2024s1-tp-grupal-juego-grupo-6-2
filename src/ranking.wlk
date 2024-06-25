object ranking {

	var record = 0

	method top() {
		return record
	}

	method guardar(monedas) {
		record = record.max(monedas)
	}

}

