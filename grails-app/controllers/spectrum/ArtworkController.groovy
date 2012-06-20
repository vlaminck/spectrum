package spectrum

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class ArtworkController {

	static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

	def index() {
		redirect action: 'list', params: params
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[artworkInstanceList: Artwork.list(params), artworkInstanceTotal: Artwork.count()]
	}

	def create() {
		switch (request.method)
		{
			case 'GET':
				[artworkInstance: new Artwork(params)]
				break
			case 'POST':
				def artworkInstance = new Artwork(params)
				if (!artworkInstance.save(flush: true))
				{
					render view: 'create', model: [artworkInstance: artworkInstance]
					return
				}

				flash.message = message(code: 'default.created.message', args: [message(code: 'artwork.label', default: 'Artwork'), artworkInstance.id])
				redirect action: 'show', id: artworkInstance.id
				break
		}
	}

	def show() {
		def artworkInstance = Artwork.get(params.id)
		if (!artworkInstance)
		{
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'artwork.label', default: 'Artwork'), params.id])
			redirect action: 'list'
			return
		}

		[artworkInstance: artworkInstance]
	}

	def edit() {
		switch (request.method)
		{
			case 'GET':
				def artworkInstance = Artwork.get(params.id)
				if (!artworkInstance)
				{
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'artwork.label', default: 'Artwork'), params.id])
					redirect action: 'list'
					return
				}

				[artworkInstance: artworkInstance, artistInstance: artworkInstance.artist]
				break
			case 'POST':
				def artworkInstance = Artwork.get(params.id)
				if (!artworkInstance)
				{
					flash.message = message(code: 'default.not.found.message', args: [message(code: 'artwork.label', default: 'Artwork'), params.id])
					redirect action: 'list'
					return
				}

				if (params.version)
				{
					def version = params.version.toLong()
					if (artworkInstance.version > version)
					{
						artworkInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
										[message(code: 'artwork.label', default: 'Artwork')] as Object[],
										"Another user has updated this Artwork while you were editing")
						render view: 'edit', model: [artworkInstance: artworkInstance, artistInstance: artworkInstance.artist]
						return
					}
				}

				artworkInstance.properties = params

				if (!artworkInstance.save(flush: true))
				{
					render view: 'edit', model: [artworkInstance: artworkInstance, artistInstance: artworkInstance.artist]
					return
				}

				flash.message = message(code: 'default.updated.message', args: [message(code: 'artwork.label', default: 'Artwork'), artworkInstance.id])
				redirect controller: "artist", action: 'show', id: artworkInstance.artist.id
				break
		}
	}

	def delete() {
		def artworkInstance = Artwork.get(params.id)
		def artistInstance = artworkInstance.artist
		if (!artworkInstance)
		{
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'artwork.label', default: 'Artwork'), params.id])
			redirect controller: "artist", action: 'show', id: artistInstance.id
			return
		}

		try
		{
			artworkInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'artwork.label', default: 'Artwork'), params.id])
			redirect controller: "artist", action: 'show', id: artistInstance.id
		}
		catch (DataIntegrityViolationException e)
		{
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'artwork.label', default: 'Artwork'), params.id])
			redirect controller: "artist", action: 'show', id: artistInstance.id
		}
	}
}
