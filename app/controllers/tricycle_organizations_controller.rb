class TricycleOrganizationsController < ApplicationController
	def show 
		@organization = TricycleOrganization.find(params[:id])
		respond_to do |format|
      format.html
      format.pdf do
        pdf = Reports::TricycleOrganizationReportPdf.new(@organization, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Tricycle Organization Report.pdf"
      end
    end 
	end 
end 