package spectrum

class SaleService {

	def getCurrentSale() {
		return findCurrentSale()
	}

	private findCurrentSale() {
		Sale.findByEndDateIsNull()
	}
}
