module RoomsHelper

	def password
    @password
  end

def password=(password_str)

    @password= password_str
    self.salt   = BCrypt::Engine.generate_salt
    self.password_digest = BCrypt::Engine.hash_secret(password_str, salt)
 end
end
