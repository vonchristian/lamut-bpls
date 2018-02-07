class TaxpayersController < ApplicationController
  def index
    @taxpayers = Taxpayer.joins(:addresses).distinct.page(params[:page]).per(50)
  end
  def new
    @taxpayer = Taxpayer.new
    authorize @taxpayer
    @taxpayer.build_tin
    @taxpayer.addresses.build
  end
  def create
    @taxpayer = Taxpayer.create(taxpayer_params)
    authorize @taxpayer
    if @taxpayer.save
      redirect_to @taxpayer, notice: 'Taxpayer information saved successfully.'
      # ActionCable.server.broadcast 'taxpayers', html: render_to_string('taxpayers/partials/count', layout: false)
    else
      render :new
    end
  end
  def show
    load_taxpayer
  end
  def edit
    @taxpayer = Taxpayer.friendly.find(params[:id])
    authorize @taxpayer
  end

  def update
    @taxpayer = Taxpayer.friendly.find(params[:id])
    authorize @taxpayer
    @taxpayer.update(taxpayer_params)
    if @taxpayer.save
      redirect_to @taxpayer, notice: "Taxpayer's information updated successfully."
    else
      render :edit
    end
  end
  def destroy
    @taxpayer = Taxpayer.friendly.find(params[:id])
    authorize @taxpayer
    @taxpayer.destroy
    redirect_to taxpayers_url, notice: "Taxpayer destroyed successfully."
  end

  private
  def load_taxpayers
    @taxpayers ||= taxpayer_scope.to_a
  end

  def load_taxpayer
    @taxpayer ||= taxpayer_scope.friendly.find(params[:id])
  end

  def taxpayer_params
    params.require(:taxpayer).permit(:avatar, :first_name, :middle_name, :last_name, :contact_number,
                                            :email, :sex, tin_attributes: [:number], :addresses_attributes => [:id, :street, :barangay_id, :municipality_or_city_id, :province_id])
  end
  def taxpayer_scope
    Taxpayer.all
  end
end
