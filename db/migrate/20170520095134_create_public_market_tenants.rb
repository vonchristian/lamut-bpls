class CreatePublicMarketTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :public_market_tenants, id: :uuid do |t|
      t.integer :vendor_type

      t.timestamps
    end
    add_index :public_market_tenants, :vendor_type
  end
end
