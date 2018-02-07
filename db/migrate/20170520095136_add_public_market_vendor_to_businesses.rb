class AddPublicMarketVendorToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :public_market_vendor, :boolean, default: false
  end
end
