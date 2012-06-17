package spectrum

class SaleController {

	def index() {
		def currentSale = findCurrentSale()
		return [saleInstance: currentSale]
	}

	private findCurrentSale() {
		Sale.findByEndDateIsNull()
	}

	def artists() {
		def artistList = Artist.list()
		render(view: "../artist/list", model: [artistInstanceList: artistList, artistInstanceTotal: Artist.count()])
	}

	def show() {
		def sale = Sale.get(params.id)
		return [saleInstance: sale]
	}

	def startSale() {
		println(params)
		if (!findCurrentSale())
		{
			def sale = new Sale(startingCash: params.startingCash as Double)
			if (sale.save())
			{
				flash.message = "Your sale has started!"
			}
			else
			{
				flash.error = "Unable to start sale..."
			}
		}
		else {
			flash.warn = "You must end the current sale before starting another."
		}
		redirect action: "index"
	}

	def endSale() {
		println(params)
		def sale = findCurrentSale()
		sale.endDate = new Date()
		sale.save()
		redirect(action: "show", id: sale.id)

	}

}
