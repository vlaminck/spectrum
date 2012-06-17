package spectrum

class IfSaleTagLib {
	def saleService
	def ifSale = { attrs, body ->
		if (saleService.getCurrentSale())
		{
			out << body()
		}

	}

}
