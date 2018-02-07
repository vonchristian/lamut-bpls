class AddPublicMarketVendorIdToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :businesses, :public_market_tenant, foreign_key: true, type: :uuid
  end
end
p
