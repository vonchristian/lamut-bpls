class BusinessesController < ApplicationController
  def index
    if params[:search].present?
      @businesses = Business.text_search(params[:search]).page(params[:page]).per(50)
    else
      @businesses = Business.all.order(:created_at => "DESC").page(params[:page]).per(50)
    end
    respond_to do |format|
      format.html
      format.xlsx
    end
  end
  def show
    @business = Business.friendly.find(params[:id])
    @verification = Businesses::BusinessRequirements::Verification.new
  end
  def destroy
    @business = Business.friendly.find(params[:id])
    @business.destroy
    redirect_to businesses_path, alert: "Business deleted successfully."
  end
end
