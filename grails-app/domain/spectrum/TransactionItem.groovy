package spectrum

class TransactionItem {

	Long artworkId
	Integer qtySold
	Double priceEach
	String artworkTitle
	String artistName

	static transients = ['artwork', 'totalPrice', 'totalTax']

	static constraints = {

	}

	def getArtwork() {
		return Artwork.get(artworkId)
	}

	def getTotalPrice() {
		return qtySold * priceEach
	}

	def getTotalTax() {
		return totalPrice * 0.0775
	}

}
