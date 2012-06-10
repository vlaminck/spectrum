import security.*

class BootStrap {

	def init = { servletContext ->
		def authority = 'ROLE_ADMIN'
		def username = 'katie.siewert@gmail.com'
		createUsers(authority, username)

		println Role.list()
		println User.list()
		println UserRole.list()

	}
	def destroy = {
	}

	def createUsers(authority, username) {
		def role = Role.findByAuthority(authority) ?: new Role(authority: authority).save(flush: true)
		def user = User.findByUsername(username) ?: new User(username: username, password: 'test', enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false).save(flush: true)
		if (!UserRole.findByUser(user)) UserRole.create(user, role, true)
	}
}
