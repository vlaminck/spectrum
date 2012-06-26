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

	static mapping = {
		transactionItems cascade: 'all'
	}

	static transients = ['totalBeforeTax', 'totalWithTax', 'totalTax', 'totalCash', 'totalCheck', 'totalCreditCard']

	static constraints = {

		paymentType1(nullable: false, inList: paymentTypes)
		paymentAmount1(nullable: false)
		paymentType2(nullable: true, inList: paymentTypes)
		paymentAmount2(nullable: true)
		paymentType3(nullable: true, inList: paymentTypes)
		paymentAmount3(nullable: true)

	}

	static paymentTypes = ["Credit Card", "Cash", "Check"]

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

	def getTotalCash() {
		def total = 0.0
		if (paymentType1 == "Cash")
		{
			total += paymentAmount1
		}
		if (paymentType2 == "Cash" && paymentAmount2)
		{
			total += paymentAmount2
		}
		if (paymentType3 == "Cash" && paymentAmount3)
		{
			total += paymentAmount3
		}
		return total
	}

	def getTotalCheck () {
		def total = 0.0
		if (paymentType1 == "Check")
		{
			total += paymentAmount1
		}
		if (paymentType2 == "Check" && paymentAmount2)
		{
			total += paymentAmount2
		}
		if (paymentType3 == "Check" && paymentAmount3)
		{
			total += paymentAmount3
		}
		return total
	}

	def getTotalCreditCard () {
		def total = 0.0
		if (paymentType1 == "Credit Card")
		{
			total += paymentAmount1
		}
		if (paymentType2 == "Credit Card" && paymentAmount2)
		{
			total += paymentAmount2
		}
		if (paymentType3 == "Credit Card" && paymentAmount3)
		{
			total += paymentAmount3
		}
		return total
	}
}


