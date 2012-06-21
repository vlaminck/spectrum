package spectrum

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class SaleController {

	def saleService

	def index() {
		Sale currentSale = findCurrentSale()
		def saleList = Sale.list(sort: "startDate", order: "desc")
		return [saleInstance: currentSale, saleList: saleList]
	}

	private findCurrentSale() {
		saleService.getCurrentSale()
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
			def sale = new Sale(name: params.name, startingCash: params.startingCash as Double)
			if (sale.save())
			{
				flash.message = "Your sale has started!"
			}
			else
			{
				flash.error = "Unable to start sale..."
			}
		}
		else
		{
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

	def transactions() {
		def sale
		if (params.saleId)
		{
			sale = Sale.get(params.saleId)
		}
		else
		{
			sale = findCurrentSale()
		}
		if (!sale)
		{
			redirect(action: "index")
		}
		return [sale: sale]
	}

	def voidTransaction() {
		def sale = Sale.get(params.saleId)
		def transaction = Transaction.get(params.transactionId)
		def transactionItemsList = transaction.transactionItems
		def successMessage = "Successfully voided transaction. Please refund \$${transaction.paymentAmount1} ${transaction.paymentType1}"
		if (transaction.paymentAmount2)
		{
			successMessage += ", \$${transaction.paymentAmount2} ${transaction.paymentType2}"
			if (transaction.paymentAmount3)
			{
				successMessage += ", \$${transaction.paymentAmount3} ${transaction.paymentType3}"
			}
		}
		successMessage += ".<script type='text/javascript'>alert('${successMessage}')</script>"
		def saveSuccess = true
		def artworkErrors = []
		transactionItemsList.each {
			def artwork = it.artwork
			artwork.qtyAvailable += it.qtySold
			if (!artwork.save(flush: true))
			{
				saveSuccess = false
				println("Failed to save artwork: ${artwork?.id}")
				artworkErrors << artwork
			}
		}
		if (!saveSuccess)
		{
			flash.error = "We were unable to readd ${artworkErrors.collect {it.title}.join(', ')} to inventory."
		}
		else
		{
			sale.removeFromTransactions(transaction)
			sale.save(flush: true)
			transaction.delete()
			flash.warn = successMessage
		}
		redirect(action: "transactions")
	}
}

