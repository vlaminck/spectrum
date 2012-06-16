package spectrum

class CartController {

	def index() { redirect(action: "show") }

	def show() {
		def cart = getShoppingCart()
		def artworkList = []
		cart.artworks.each {
			def artworkMap = [:]
			def artwork = Artwork.get(it.artworkId)
			artworkMap.title = artwork.title
			artworkMap.artist = artwork.artist.fullName
			artworkMap.price = artwork.price
			artworkMap.artworkQty = it.artworkQty
			artworkList << artworkMap
		}
		println(artworkList)
		return [artworkList: artworkList]
	}

	def addToCart() {
		println(params)
		def artwork = Artwork.get(params.id)
		def cart = getShoppingCart()
		def addNew = true

		cart.artworks.each {
			if (it.artworkId == params.id)
			{
				addNew = false
				if ((artwork.qtyAvailable - it.artworkQty) >= params.qtyToPurchase.toInteger())
				{
					it.artworkQty += params.qtyToPurchase as Integer
					flash.message = "There are now ${it.artworkQty} of ${artwork.title} in the cart"
				}
				else
				{
					flash.error = "You've tried to add more items than are available"
				}
			}
		}

		if (addNew)
		{
			if (artwork.qtyAvailable >= params.qtyToPurchase.toInteger())
			{
				def entry = [artworkId: params.id, artworkQty: params.qtyToPurchase as Integer]
				cart.artworks << entry
				flash.message = "There are now ${params.qtyToPurchase} of ${artwork.title} in the cart"
			}
			else
			{
				flash.error = "You've tried to add more items than are available"
			}
		}
		println(cart)
		redirect(controller: "artist", action: "show", id: params.artistId)
	}

	def clearCart() {
		def cart = getShoppingCart()
		cart.artworks = [] as List
		redirect(action: "show")
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
}
