package spectrum

class Sale {

	Date startDate = new Date()
	Date endDate
	Double startingCash

	static hasMany = [transactions: Transaction]

	static transients = ['endingCash', 'totalBeforeTax', 'totalWithTax', 'totalTax', 'totalCash']

	static constraints = {
		endDate(nullable: true)
	}

	def getEndingCash() {
		return startingCash + totalCash
	}

	def getTotalBeforeTax() {
		def total = 0.0
		transactions.each {
			total += it.totalBeforeTax
		}
		return total
	}

	def getTotalWithTax() {
		def total = 0.0
		transactions.each {
			total += it.totalWithTax
		}
		return total
	}

	def getTotalTax() {
		def total = 0.0
		transactions.each {
			total += it.totalTax
		}
		return total
	}

	def getTotalCash() {
		def total = 0.0
		transactions.each {
			total += it.totalCash
		}
		return total
	}
}

