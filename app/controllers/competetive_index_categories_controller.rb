class CompetetiveIndexCategoriesController < ApplicationController
  def show
    @category = BploSection::Settings::CompetetiveIndexCategory.find(params[:id])
    @businesses = @category.businesses.page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Reports::CmciPdf.new(@businesses, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Registered Businesses.pdf"
      end
    end
  end
end
