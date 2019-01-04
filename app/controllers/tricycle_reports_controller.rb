class TricycleReportsController < ApplicationController
	def index
		@tricycle_organizations = TricycleOrganization.all
    @tricycles = Tricycle.all
    respond_to do |format|
      format.html
      format.xlsx
    end
	end
end
