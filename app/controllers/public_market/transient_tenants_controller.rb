module PublicMarket
  class TransientTenantsController < ApplicationController
    def index
      @public_market_tenant = PublicMarketTenant.find_by(vendor_type: 1)
      @businesses = @public_market_tenant.businesses
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PublicMarket::TransientTenantPdf.new(@businesses, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Public Market Regular Tenant Report.pdf"
        end
      end
    end
  end
end
