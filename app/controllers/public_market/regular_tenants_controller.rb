module PublicMarket
  class RegularTenantsController < ApplicationController
    def index
      @public_market_tenant = PublicMarketTenant.find_by(vendor_type: 0)
      @businesses = @public_market_tenant.businesses
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PublicMarket::RegularTenantPdf.new(@businesses, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Public Market Regular Tenant Report.pdf"
        end
      end
    end
  end
end
