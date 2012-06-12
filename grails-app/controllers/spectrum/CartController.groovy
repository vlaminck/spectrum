package spectrum

class CartController {

	def index() { }

	def addToCart() {
		println(params)
		def artwork = Artwork.get(params.id)
		def cart = getShoppingCart()
		def addNew = true
		cart.artworks.each {
			if (it.artworkId == params.id)
			{
				it.artworkQty += params.qtyToPurchase as Integer
				addNew = false
			}

		}
		if (addNew)
		{
			if (artwork.qtyAvailable > params.qtyToPurchase)
			{
				def entry = [artworkId: params.id, artworkQty: params.qtyToPurchase as Integer]
				cart.artworks << entry
			}
else {
				flash.error = "You've tried to add more items than are available"
			}
		}

		println(cart)
		redirect (controller: "artist", action: "show", id: params.artistId)
	}

	def clearCart() {
		def cart = getShoppingCart()
		cart.artworks = []
		redirect(action: "show")
	}

	private getShoppingCart() {
		if (!session.shoppingCart)
		{
			session.shoppingCart = [:]
		}
		if (!session.shoppingCart.artworks)
		{
			session.shoppingCart.artworks = []
		}
		return session.shoppingCart
	}
}
