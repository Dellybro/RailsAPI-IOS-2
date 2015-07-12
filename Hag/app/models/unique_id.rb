class UniqueId < ActiveRecord::Base
	validates :user_id, presence: true
end
