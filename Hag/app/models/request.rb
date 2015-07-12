class Request < ActiveRecord::Base
	belongs_to :provider

	validates_uniqueness_of :client_id, :scope => :provider
	#Make sure consumer can't send more than one request at a time
end
