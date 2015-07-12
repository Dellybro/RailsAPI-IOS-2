class Provider < ActiveRecord::Base
	validates :first_name, presence: true, length: {maximum: 25}
	validates :last_name, presence: true, length: {maximum: 25}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    before_create :set_auth_token
	validates :password, confirmation: true, length: { minimum: 6},
    		unless: Proc.new { |provider| provider.password.blank? }
	before_save :downcase_email
	#validates :bio, length: {maximum: 300}
	validates :city, length: {minimum: 2}

	has_many :services
	has_many :requests
	has_many :client_relations, class_name:  "Relationship",
                                  dependent:   :destroy

	#mount_uploader :propic, ProfilePictureUploader

	has_secure_password

	def Provider.authenticate(username, password)
		Provider.find_by(email: username).try(:authenticate, password)
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
			self.city = self.city.downcase
			self.email = self.email.downcase
		end
end
