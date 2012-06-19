package spectrum

class Artwork {

	String title
	Double price
	String materials
	Integer qtyAvailable

	static transients = ['priceAsCurrency']

	static belongsTo = [artist: Artist]

	static constraints = {
		title(nullable: false, blank: false)
		price(nullable: false)
		materials(nullable: true, blank: false)
		qtyAvailable(nullable: false)
	}

	def getPriceAsCurrency() {
		return g.formatNumber(number:price.round(2), type:"number", currencyCode:"USD")
	}
}
