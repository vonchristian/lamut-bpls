class TricycleReportsController < ApplicationController 
	def index 
		@tricycle_organizations = TricycleOrganization.all 
	end 
end 