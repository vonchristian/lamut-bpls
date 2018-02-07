class TricyclesController < ApplicationController
  def index
    if params[:search].present?
      @tricycles = Tricycle.text_search(params[:search]).page(params[:page]).per(50)
    else
      @tricycles = Tricycle.all.page(params[:page]).per(50)
    end
    @tricycle_organizations = TricycleOrganization.all
  end
  def new
    @tricycle = Tricycle.new
    authorize @tricycle
  end
  def create
    @tricycle = Tricycle.create(tricycle_params)
    authorize @tricycle
    if @tricycle.save
      redirect_to @tricycle, notice: "Tricycle information saved successfully."
    else
      render :new
    end
  end
  def show
    @tricycle = Tricycle.find(params[:id])
  end
  def edit
    @tricycle = Tricycle.find(params[:id])
    authorize @tricycle
  end

  def update
    @tricycle = Tricycle.find(params[:id])
    authorize @tricycle
    @tricycle.update(tricycle_params)
    if @tricycle.valid?
      @tricycle.save
      redirect_to @tricycle, notice: "Tricycle info updated successfully."
    else
      render :edit
    end
  end
  def destroy
    @tricycle = Tricycle.find(params[:id])
    @tricycle.destroy
    redirect_to tricycles_url, notice: "Tricycle destroyed successfully"
  end

  private
  def tricycle_params
    params.require(:tricycle).permit(:mtop_number, :plate_number, :tricycle_organization_id)
  end
end
