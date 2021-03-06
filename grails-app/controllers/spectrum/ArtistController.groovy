package spectrum

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured


@Secured(['ROLE_ADMIN'])
class ArtistController {

	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		[artistInstanceList: Artist.list(), artistInstanceTotal: Artist.count()]
	}

	def create() {
		switch (request.method)
		{
			case 'GET':
				[artistInstance: new Artist(params)]
				break
			case 'POST':
				def artistInstance = new Artist(params)
				if (!artistInstance.save(flush: true))
				{
					render view: 'create', model: [artistInstance: artistInstance]
					return
				}

				flash.message = message(code: 'default.created.message', args: [message(code: 'artist.label', default: 'Artist'), artistInstance.id])
				redirect action: 'show', id: artistInstance.id
				break
		}
	}

	def show() {
		def artistInstance = Artist.get(params.id)
		if (!artistInstance)
		{
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'artist.label', default: 'Artist'), params.id])
			redirect action: 'list'
			return
		}

		[artistInstance: artistInstance]
	}

	def printLabels() {
		def artistInstanceList = []
		if (params.id)
		{
			artistInstanceList << Artist.get(params.id)
		}
		else {
			artistInstanceList = Artist.list()
		}
		if (!artistInstanceList)
		{
			flash.message = "Couldn't find any artists to print labels for."
			redirect action: 'list'
			return
		}

		[artistInstanceList: artistInstanceList]

	}

	def edit() {
		switch (request.method)
		{
			case 'GET':
				def artistInstance = Artist.get(params.id)
				if (!artistInstance)
				{
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'artist.label', default: 'Artist'), params.id])
					redirect action: 'list'
					return
				}

				[artistInstance: artistInstance]
				break
			case 'POST':
				def artistInstance = Artist.get(params.id)
				if (!artistInstance)
				{
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'artist.label', default: 'Artist'), params.id])
					redirect action: 'list'
					return
				}

				if (params.version)
				{
					def version = params.version.toLong()
					if (artistInstance.version > version)
					{
						artistInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
										[message(code: 'artist.label', default: 'Artist')] as Object[],
										"Another user has updated this Artist while you were editing")
						render view: 'edit', model: [artistInstance: artistInstance]
						return
					}
				}

				artistInstance.properties = params

				if (!artistInstance.save(flush: true))
				{
					render view: 'edit', model: [artistInstance: artistInstance]
					return
				}

				flash.message = message(code: 'default.updated.message', args: [message(code: 'artist.label', default: 'Artist'), artistInstance.id])
				redirect action: 'show', id: artistInstance.id
				break
		}
	}

	def delete() {
		def artistInstance = Artist.get(params.id)
		if (!artistInstance)
		{
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'artist.label', default: 'Artist'), params.id])
			redirect action: 'list'
			return
		}

		try
		{
			artistInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'artist.label', default: 'Artist'), params.id])
			redirect action: 'list'
		}
		catch (DataIntegrityViolationException e)
		{
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'artist.label', default: 'Artist'), params.id])
			redirect action: 'show', id: params.id
		}
	}

	def addArtwork() {
		println "addArtwork params: ${params}"
		def artist = Artist.get(params.artistId)
		redirect(action: "show", id: artist.id)
		if (artist)
		{
			def artwork = new Artwork(artist: artist, title: params.title, price: params.price, materials: params.materials, qtyAvailable: params.qtyAvailable)
			artist.addToArtworks(artwork)
			if (artist.save())
			{
				if (artwork.save())
				{
					flash.message = "The artwork has been saved"
				}
				else
				{
					flash.error = "Unable to save that artwork"
				}
			}
			else
			{
				flash.error = "Unable to save that artwork"
			}
		}
		else
		{
			flash.error = "We couldn't find that Artist"
		}
	}

}

