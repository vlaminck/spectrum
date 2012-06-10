package spectrum

import org.springframework.dao.DataIntegrityViolationException

class ArtistController {

	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[artistInstanceList: Artist.list(params), artistInstanceTotal: Artist.count()]
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
		println(params)
		def artist = Artist.get(params.artistId)
		def artwork = new Artwork()
		artwork.properties = params
		artwork.save()
		artist.addToArtworks(artwork)
		artist.save()
		redirect(action: "show",id: artist.id)
	}
}

