import security.*
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication
import spectrum.Artist
import spectrum.Artwork

class BootStrap {

	def GRAILS_ENVIRONMENT = GrailsUtil.getEnvironment()

	def init = { servletContext ->
		if (GRAILS_ENVIRONMENT == GrailsApplication.ENV_DEVELOPMENT)
		{
			createUser('ROLE_ADMIN', 'katie.siewert@gmail.com')
			createUser('ROLE_ADMIN', 'mandersen@resource-mn.org')
			createArtistsArtworks()
		}
	}
	def destroy = {
	}

	def createUser(authority, username) {
		def role = Role.findByAuthority(authority) ?: new Role(authority: authority).save(flush: true)
		def user = User.findByUsername(username) ?: new User(username: username, password: 'test', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false).save(flush: true)
		if (!UserRole.findByUser(user)) UserRole.create(user, role, true)
	}

	def createArtistsArtworks() {
		def artist1 = new Artist(firstName: "cynTHIA").save()
		def artist2 = new Artist(firstName: "Faye", lastName: "Buffington-Howell").save()
		def artist3 = new Artist(firstName: "Clarence", lastName: "Reed").save()

		def artwork1 = new Artwork(title: "Untitled", price: "59", materials: "Watercolor on Canvas", qtyAvailable: "3", artist: artist1).save()
		def artwork2 = new Artwork(title: "Jesus Blows", price: "999", materials: "Watercolor on Canvas", qtyAvailable: "1", artist: artist2).save()
		def artwork3 = new Artwork(title: "But...I Love Her", price: "250", materials: "Oil on Wood", qtyAvailable: "1", artist: artist3).save()
		def artwork4 = new Artwork(title: "Feather Earrings", price: "20", qtyAvailable: "15", artist: artist1).save()
		def artwork5 = new Artwork(title: "Magnets", price: "2", qtyAvailable: "100", artist: artist2).save()
		def artwork6 = new Artwork(title: "Minnesota", price: "300", materials: "Mixed Media", qtyAvailable: "1", artist: artist3).save()

		artist1.addToArtworks(artwork1)
		artist2.addToArtworks(artwork2)
		artist3.addToArtworks(artwork3)
		artist1.addToArtworks(artwork4)
		artist2.addToArtworks(artwork5)
		artist3.addToArtworks(artwork6)

		artist1.save()
		artist2.save()
		artist3.save()
	}
}
