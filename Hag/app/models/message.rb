class Message < ActiveRecord::Base

	has_many :notes

	validates :client_id, presence: true
	validates :provider_id, presence: true
end
