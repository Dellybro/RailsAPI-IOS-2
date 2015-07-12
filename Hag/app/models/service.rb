class Service < ActiveRecord::Base

	self.inheritance_column = nil

	validates :type, length: { maximum: 255, minimum: 2 }
    belongs_to :provider
	validates_uniqueness_of :type, :scope => :provider
	#Make sure users can't have more than one of the same service
	#That is what is essential in services
end
