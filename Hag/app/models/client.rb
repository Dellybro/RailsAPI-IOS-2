class Client < ActiveRecord::Base
	validates :first_name, presence: true, length: {maximum: 25}
	validates :last_name, presence: true, length: {maximum: 25}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    before_create :set_auth_token
	validates :password, confirmation: true, length: { minimum: 6},
    		unless: Proc.new { |user| user.password.blank? }
	before_save :downcase_email
	#validates :bio, length: {maximum: 300}
	validates :city, length: {minimum: 2}

	#mount_uploader :propic, ProfilePictureUploader

	has_secure_password

	def Client.authenticate(username, password)
		Client.find_by(email: username).try(:authenticate, password)
	end



	private

		def set_auth_token
			return if auth_token.present?
			self.auth_token = generate_auth_token
		end

		def generate_auth_token
			loop do
				token = SecureRandom.hex
				break token unless self.class.exists?(auth_token: token)
			end
		end

		def downcase_email
			self.email = self.email.downcase
			self.city = self.city.downcase
		end
end
