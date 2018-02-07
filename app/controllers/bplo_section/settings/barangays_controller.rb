module BploSection
  module Settings 
    class BarangaysController < ApplicationController
      def new 
        @barangay = Addresses::Barangay.new 
      end 
      def create 
        @barangay = Addresses::Barangay.create(barangay_params)
        @barangay.municipality_or_city = Addresses::MunicipalityOrCity.first
        if @barangay.save 
          redirect_to bplo_section_settings_url, notice: 'Barangay saved successfully.'
        else 
          render :new 
        end 
      end 

      private 
      def barangay_params
        params.require(:addresses_barangay).permit(:name)
      end 
    end 
  end 
end 