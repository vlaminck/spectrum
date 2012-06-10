package spectrum

class Transaction {

	Date dateSold = new Date()
	String paymentType1
	Double paymentAmount1
	String paymentType2
	Double paymentAmount2
	String paymentType3
	Double paymentAmount3

	static hasMany = [transactionItems: TransactionItem]

	static transients = ['totalBeforeTax', 'totalWithTax', 'totalTax']

	static constraints = {

		paymentType2(nullable: true)
		paymentAmount2(nullable: true)
		paymentType3(nullable: true)
		paymentAmount3(nullable: true)

	}

	def getTotalBeforeTax() {
		def total = 0.0
		transactionItems.each {
			total += it.totalPrice
		}
		return total
	}

	def getTotalWithTax() {
		def total = 0.0
		transactionItems.each {
			total += it.totalPrice + it.totalTax
		}
		return total
	}

	def getTotalTax() {
		def total = 0.0
		transactionItems.each {
			total += it.totalTax
		}
		return total
	}
}

