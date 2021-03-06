package spectrum

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class CartController {

	def saleService

	def index() { redirect(action: "show") }

	def show() {
		def cart = getShoppingCart()
		def artworkList = []
		double total = 0.0
		List artworks = cart.artworks as List
		artworks.each {
			def artworkMap = [:]
			def artwork = Artwork.get(it.artworkId)
			artworkMap.artworkId = artwork.id
			artworkMap.artistId = artwork.artist.id
			artworkMap.title = artwork.title
			artworkMap.artist = artwork.artist.fullName
			artworkMap.price = artwork.price
			artworkMap.artworkQty = it.artworkQty
			artworkList << artworkMap
			total += artwork.price * artworkMap.artworkQty
		}
		def totalWithTax = total * 1.0775
		return [artworkList: artworkList, total: total, totalWithTax: totalWithTax]
	}

	def addToCart() {
		println(params)
		def artwork = Artwork.get(params.id)
		def cart = addItemToCart(artwork, params)
		println(cart)
		redirect(controller: "artist", action: "show", id: params.artistId)
	}


	def removeFromCart() {
		println(params)
		def cart = getShoppingCart()
		def itemsToKeep = []
		List artworks = cart.artworks as List
		artworks.each {
			if (it.artworkId != params.id)
			{
				itemsToKeep << it
			}
		}
		emptyCart()
		itemsToKeep.each {
			def artwork = Artwork.get(it.artworkId)
			def cartParams = [id: it.artworkId, qtyToPurchase: it.artworkQty]
			cart = addItemToCart(artwork, cartParams)
		}
		println(cart)
		redirect(action: "show")
	}

	def clearCart() {
		emptyCart()
		redirect(action: "show")
	}

	def checkOut() {

		cleanParams()
		def cart = getShoppingCart()
		if (cart.artworks)
		{
			def sale = saleService.getCurrentSale()
			def transaction = new Transaction(
							paymentType1: params.paymentType1,
							paymentAmount1: params.paymentAmount1,
							paymentType2: params.paymentType2,
							paymentAmount2: params.paymentAmount2,
							paymentType3: params.paymentType3,
							paymentAmount3: params.paymentAmount3
			)

			def changeDue = params.changeDue.toDouble()
			def cash
			if (params.paymentType1 == 'Cash')
			{
				cash = changeDue > 0 ? params.paymentAmount1.toDouble() - changeDue : params.paymentAmount1 as Double
				transaction.paymentAmount1 = cash
			}
			else if (params.paymentType2 == 'Cash')
			{
				cash = changeDue > 0 ? params.paymentAmount2.toDouble() - changeDue : params.paymentAmount2 as Double
				transaction.paymentAmount2 = cash
			}
			else if (params.paymentType3 == 'Cash')
			{
				cash = changeDue > 0 ? params.paymentAmount3.toDouble() - changeDue : params.paymentAmount3 as Double
				transaction.paymentAmount3 = cash
			}

			if (changeDue > 0)
			{
				flash.message = "Please give \$${params.changeDue} change. <script type='text/javascript'>alert('Please give \$${params.changeDue} change')</script>"
			}

			transaction.save()
			sale.addToTransactions(transaction)
			sale.save()

			List artworks = cart.artworks as List
			artworks.each {
				def artwork = Artwork.get(it.artworkId)
				def transactionItem = new TransactionItem(
								artworkId: it.artworkId,
								qtySold: it.artworkQty,
								priceEach: artwork.price,
								artworkTitle: artwork.title,
								artistName: artwork.artist.fullName
				)
				if (transactionItem.save())
				{
					artwork.qtyAvailable -= it.artworkQty
					artwork.save()
				}
				transaction.addToTransactionItems(transactionItem)
				transaction.save()
			}
			emptyCart()
			redirect(controller: "sale", action: "transactions", id: transaction?.id)
		}
		else
		{
			flash.warn = "There are no items to purchase."
			redirect(controller: "artist", action: "list")
		}
	}

	private cleanParams() {
		params.paymentAmount1 = params.paymentAmount1.replaceAll(',', '.')
		params.paymentAmount2 = params.paymentAmount2.replaceAll(',', '.')
		params.paymentAmount3 = params.paymentAmount3.replaceAll(',', '.')
	}

	private emptyCart() {
		def cart = getShoppingCart()
		cart.artworks = [] as List
	}

	private getShoppingCart() {
		if (!session.shoppingCart)
		{
			session.shoppingCart = [:]
		}
		if (!session.shoppingCart.artworks)
		{
			session.shoppingCart.artworks = [] as List
		}
		return session.shoppingCart
	}

	private addItemToCart(Artwork artwork, params) {
		def cart = getShoppingCart()
		def addNew = true
		List artworks = cart.artworks as List
		artworks.each {
			if (it.artworkId == params.id)
			{
				if (artwork.qtyAvailable > 0)
				{
					addNew = false
					if ((artwork.qtyAvailable - it.artworkQty) >= params.qtyToPurchase.toInteger())
					{
						it.artworkQty += params.qtyToPurchase as Integer
						flash.message = "There are now ${it.artworkQty} of <span class='italicize'>${artwork.title}</span> in the cart ${g.link(style: 'float: right;', class: 'btn btn-primary', controller: 'cart', action: 'show') {'Shopping Cart'}}"
					}
					else
					{
						flash.error = "You've tried to add more items than are available"
					}
				}
				else
				{
					flash.warn = "There are no more of <span class='italicize'>${artwork.title}</span> available"
				}
			}
		}

		if (addNew)
		{
			if (artwork.qtyAvailable > 0)
			{
				if (artwork.qtyAvailable >= params.qtyToPurchase.toInteger())
				{
					def entry = [artworkId: params.id, artworkQty: params.qtyToPurchase as Integer]
					cart.artworks << entry
					flash.message = "There are now ${params.qtyToPurchase} of <span class='italicize'>${artwork.title}</span> in the cart ${g.link(style: 'float: right;', class: 'btn btn-primary', controller: 'cart', action: 'show') {'Shopping Cart'}}"
				}
				else
				{
					flash.error = "You've tried to add more items than are available"
				}
			}
			else
			{
				flash.warn = "There are no more of <span class='italicize'>${artwork.title}</span> available"
			}
		}
		cart
	}

}
