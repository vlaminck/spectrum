package spectrum

class Artist {
	String firstName
	String middleName
	String lastName

	static hasMany = [artworks: Artwork]

	static constraints = {
		firstName(nullable: false, blank: false)
		middleName(nullable: true, blank: false)
		lastName(nullable: true, blank: false)
	}
}
