module Fees 
	class DocumentaryStampFeesController < ApplicationController
		def edit
			@fee = Fees::DocumentaryStampFee.find(params[:id])
		end 
		def update 
			@fee = Fees::DocumentaryStampFee.find(params[:id])
			@fee.update(fee_params)
			if @fee.save 
				redirect_to business_url(@fee.business), notice: "Fee updated successfully."
			else 
				render :edit
			end 
		end 

		private 
		def fee_params
			params.require(:fees_documentary_stamp_fee).permit(:amount, :calendar_year)
		end
	end 
end 
