class Relationship < ActiveRecord::Base
	belongs_to :provider

	validates_uniqueness_of :client_id, :scope => :provider
	#validates_uniqueness_of :client_id, :provider_id, :scope => :client_relations
end
