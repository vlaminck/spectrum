package spectrum

class Artist {
	String firstName
	String middleName
	String lastName

	static hasMany = [artworks: Artwork]

	static transients = ['fullName']

	static constraints = {
		firstName(nullable: false, blank: false)
		middleName(nullable: true, blank: false)
		lastName(nullable: true, blank: false)
	}
	def getFullName() {
		def fullName = firstName
		if (middleName) {
			fullName += " ${middleName}"
		}
		if (lastName) {
			fullName += " ${lastName}"
		}
		return fullName
	}
}
