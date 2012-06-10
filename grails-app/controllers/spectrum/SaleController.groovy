package spectrum

class SaleController {

	def index() {
		redirect(action: "artists")
	}

	def artists() {
		def artistList = Artist.list()
		render(view: "../artist/list", model: [artistInstanceList: artistList, artistInstanceTotal: Artist.count()])
	}

	def show() {
		def artist = Artist.get(params.id)
		return [artistInstance: artist]
	}
}
