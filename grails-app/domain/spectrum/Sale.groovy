package spectrum

class Sale {

	Date startDate = new Date()
	Date endDate
	Double startingCash

	static transients = ['endingCash']

	static constraints = {
	}

	def getEndingCash() {}
}
